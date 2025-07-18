package main

import (
	"fmt"
	"log"
	"net/http"
	"strings"
	"time"
)

// URLRecord represents a row in the CSV
type URLRecord struct {
	Name       string
	NewDomain  string
	NewCheck   string
	NewBase    string
	OldDomain  string
	OldCheck   string
	OldBase    string
	OldURI     string
	NewURI     string
	OldFullURL string
	NewFullURL string
}

// checkURL performs an HTTP GET request and returns the status code
func checkURL(url string) (string, error) {
	client := &http.Client{
		Timeout: 10 * time.Second,
	}
	resp, err := client.Get(url)
	if err != nil {
		log.Printf("Error checking URL %s: %v", url, err)
		return "Error", err
	}
	defer resp.Body.Close()
	log.Printf("Checked URL %s: Status %d", url, resp.StatusCode)
	return fmt.Sprintf("%d", resp.StatusCode), nil
}

// constructURL builds a URL from domain, base, and uri
func constructURL(domain, name, base, uri string) string {
	parts := []string{strings.TrimSuffix(domain, "/")}
	if name != "" {
		parts = append(parts, strings.Trim(name, "/"))
	}
	if base != "" {
		parts = append(parts, strings.Trim(base, "/"))
	}
	if uri != "" {
		parts = append(parts, strings.Trim(uri, "/"))
	}
	return strings.Join(parts, "/")
}

// stopWords is a list of common words to remove from regular slugs (Drupal-like)
var stopWords = map[string]bool{
	"a":     true,
	"an":    true,
	"the":   true,
	"and":   true,
	"or":    true,
	"but":   true,
	"in":    true,
	"on":    true,
	"at":    true,
	"to":    true,
	"for":   true,
	"of":    true,
	"with":  true,
	"by":    true,
	"from":  true,
	"up":    true,
	"about": true,
	"into":  true,
	"over":  true,
	"after": true,
}

// httpMethods is a set of HTTP methods to identify API endpoints
var httpMethods = map[string]bool{
	"post":   true,
	"get":    true,
	"put":    true,
	"delete": true,
	"patch":  true,
}

// convertToDrupalSlug converts a slug or API endpoint to Drupal-like style
func convertToDrupalSlug(slug string) string {
	// Split input into parts based on spaces
	parts := strings.Split(slug, "-")
	var words []string
	isAPIEndpoint := false

	// Check if it's an API endpoint
	if len(parts) > 1 && httpMethods[strings.ToLower(parts[0])] {
		// API endpoint format: "POST /path"
		isAPIEndpoint = true
		method := strings.ToLower(parts[0]) // e.g., "post"
		path := strings.Join(parts[1:], "") // Join path parts
		// Replace slashes with hyphens and remove curly braces
		path = strings.ReplaceAll(path, "/", "-")
		path = strings.ReplaceAll(path, "{", "")
		path = strings.ReplaceAll(path, "}", "")
		words = append([]string{method}, "a"+path)
	} else {
		// Check if slug starts with HTTP method prefix
		lowerSlug := strings.ToLower(slug)
		for method := range httpMethods {
			if strings.HasPrefix(lowerSlug, method+"-") {
				isAPIEndpoint = true
				break
			}
		}
		words = strings.Split(lowerSlug, "-")
	}

	// Process words based on whether it's an API endpoint
	var filteredWords []string
	if isAPIEndpoint {
		// For API endpoints, keep all words (including stop words)
		for _, word := range words {
			if word != "" {
				filteredWords = append(filteredWords, word)
			}
		}
	} else {
		// For regular slugs, remove stop words
		for _, word := range words {
			if word != "" && !stopWords[word] {
				filteredWords = append(filteredWords, word)
			}
		}
	}

	// If no words remain, return the original slug
	if len(filteredWords) == 0 {
		return slug
	}

	// Join words with hyphens and clean up
	result := strings.Join(filteredWords, "-")
	// Remove any double hyphens or leading/trailing hyphens
	result = strings.ReplaceAll(result, "--", "-")
	result = strings.Trim(result, "-")

	return result
}

// func main() {
// 	// Example slug
// 	slug := "configure-cells-with-a-reverse-proxy"
// 	converted := convertToDrupalSlug(slug)
// 	fmt.Printf("Original slug: %s\n", slug)
// 	fmt.Printf("Drupal-style slug: %s\n", converted)
// }

// func main() {
// 	// Open input CSV
// 	file, err := os.Open("input.csv")
// 	if err != nil {
// 		log.Fatalf("Failed to open input.csv: %v", err)
// 	}
// 	defer file.Close()

// 	// Read CSV
// 	reader := csv.NewReader(file)
// 	records, err := reader.ReadAll()
// 	if err != nil {
// 		log.Fatalf("Failed to read CSV: %v", err)
// 	}
// 	if len(records) < 2 {
// 		log.Fatal("CSV file is empty or has no data rows")
// 	}

// 	// Prepare output records with updated header
// 	header := append(records[0], "old-fullurl", "new-fullurl")
// 	outputRecords := [][]string{header} // Keep header with new columns
// 	dataRecords := records[1:]         // Process data rows

// 	// Process each record
// 	for _, record := range dataRecords {
// 		// if len(record) != 9 {
// 		// 	log.Printf("Skipping malformed record: %v", record)
// 		// 	continue
// 		// }

// 		r := URLRecord{
// 			Name:      record[0],
// 			NewDomain: record[1],
// 			NewCheck:  record[2],
// 			NewBase:   record[3],
// 			OldDomain: record[4],
// 			OldCheck:  record[5],
// 			OldBase:   record[6],
// 			OldURI:    record[7],
// 			NewURI:    record[8],
// 		}

// 		// Construct and check old URL
// 		if r.OldDomain != "" && r.OldURI != ""  && r.OldCheck != "200"{
// 			r.OldFullURL = constructURL(r.OldDomain, "", r.OldBase, convertToDrupalSlug(r.OldURI))
// 			log.Printf("Testing old URL: %s", r.OldFullURL)
// 			if status, err := checkURL(r.OldFullURL); err == nil {
// 				r.OldCheck = status
// 			} else {
// 				r.OldCheck = "Error"
// 			}
// 		}

// 		// Construct and check new URL
// 		if r.NewDomain != "" && r.NewURI != "" && r.NewCheck != "200" {
// 			r.NewFullURL = constructURL(r.NewDomain, r.Name, r.NewBase, r.NewURI)
// 			log.Printf("Testing new URL: %s", r.NewFullURL)
// 			if status, err := checkURL(r.NewFullURL); err == nil {
// 				r.NewCheck = status
// 			} else {
// 				r.NewCheck = "Error"
// 			}
// 		}

// 		// Append updated record with full URLs
// 		outputRecords = append(outputRecords, []string{
// 			r.Name,
// 			r.NewDomain,
// 			r.NewCheck,
// 			r.NewBase,
// 			r.OldDomain,
// 			r.OldCheck,
// 			r.OldBase,
// 			convertToDrupalSlug(r.OldURI),
// 			r.NewURI,
// 			r.OldFullURL,
// 			r.NewFullURL,
// 		})
// 	}

// 	// Write output CSV
// 	outputFile, err := os.Create("output.csv")
// 	if err != nil {
// 		log.Fatalf("Failed to create output.csv: %v", err)
// 	}
// 	defer outputFile.Close()

// 	writer := csv.NewWriter(outputFile)
// 	defer writer.Flush()

// 	if err := writer.WriteAll(outputRecords); err != nil {
// 		log.Fatalf("Failed to write output CSV: %v", err)
// 	}

// 	log.Println("URL checking complete. Output written to output.csv")
// }
