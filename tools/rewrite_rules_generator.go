package main

import (
	"encoding/csv"
	"fmt"
	"log"
	"os"
	"strings"
)

// generateRewriteRule creates an Apache RewriteRule for a given incoming and redirect URI
func generateRewriteRule(incomingURI, redirectURI, newDomain string) string {
	// Clean incoming URI: ensure it starts with a slash and escape special characters
	incomingClean := strings.TrimSpace(incomingURI)
	if !strings.HasPrefix(incomingClean, "/") {
		incomingClean = "/" + incomingClean
	}
	// Escape special characters for Apache regex (e.g., dots, slashes)
	//incomingEscaped := strings.ReplaceAll(incomingClean, ".", "\\.")
	//incomingEscaped = strings.ReplaceAll(incomingEscaped, "/", "\\/")
	incomingEscaped := incomingClean

	// Construct full redirect URL: new-domain + redirect-uri
	redirectClean := strings.TrimSpace(redirectURI)
	if strings.HasPrefix(redirectClean, "/") {
		redirectClean = strings.TrimPrefix(redirectClean, "/")
	}
	fullRedirectURL := fmt.Sprintf("%s/%s", strings.TrimSuffix(newDomain, "/"), redirectClean)

	// Generate RewriteRule: match incoming URI and redirect to full URL
	return fmt.Sprintf("RewriteRule ^%s$ %s [R=301,L]\n", incomingEscaped, fullRedirectURL)
}

func main() {
	// Open CSV file
	file, err := os.Open("output.csv")
	if err != nil {
		log.Fatalf("Failed to open output.csv: %v", err)
	}
	defer file.Close()

	// Read CSV
	reader := csv.NewReader(file)
	records, err := reader.ReadAll()
	if err != nil {
		log.Fatalf("Failed to read CSV: %v", err)
	}
	if len(records) < 2 {
		log.Fatal("CSV file is empty or has no data rows")
	}

	// Create output .htaccess file
	outputFile, err := os.Create(".htaccess")
	if err != nil {
		log.Fatalf("Failed to create .htaccess: %v", err)
	}
	defer outputFile.Close()

	// Write .htaccess header
	header := `# Generated .htaccess for URL redirects
RewriteEngine On
RewriteBase /
`
	if _, err := outputFile.WriteString(header); err != nil {
		log.Fatalf("Failed to write to .htaccess: %v", err)
	}

	// Process records, skipping header
	headerRow := records[0]
	incomingIndex, redirectIndex, newDomainIndex := -1, -1, -1
	for i, col := range headerRow {
		switch col {
		case "incoming-uri":
			incomingIndex = i
		case "redirect-uri":
			redirectIndex = i
		case "new-domain":
			newDomainIndex = i
		}
	}
	if incomingIndex == -1 || redirectIndex == -1 || newDomainIndex == -1 {
		log.Fatal("Required columns (incoming-uri, redirect-uri, new-domain) not found in CSV")
	}

	// Generate RewriteRules
	for i, record := range records[1:] {
		if len(record) <= incomingIndex || len(record) <= redirectIndex || len(record) <= newDomainIndex {
			log.Printf("Skipping malformed record at line %d: %v", i+2, record)
			continue
		}

		incomingURI := record[incomingIndex]
		redirectURI := record[redirectIndex]
		newDomain := record[newDomainIndex]

		if incomingURI == "" || redirectURI == "" || newDomain == "" {
			log.Printf("Skipping empty URI or domain at line %d", i+2)
			continue
		}

		// Generate and write RewriteRule
		rule := generateRewriteRule(incomingURI, redirectURI, newDomain)
		if _, err := outputFile.WriteString(rule); err != nil {
			log.Printf("Failed to write rule for line %d: %v", i+2, err)
		}
	}

	fmt.Println("Generated .htaccess with rewrite rules")
}