---
slug: what-s-new-in-pydio-8
title: "What's new in Pydio 8"
language: und
menu: "What's new in Pydio 8"
weight: 1
menu_name: menu-developer-guide
description: "Introducing the major code changes of Pydio 8"

---

## Bye bye PrototypeJS, hello ReactJS!

Pydio 8 is a major UX release, and sees the work started in Pydio 7 of transitioning legacy javascript code to new standards terminated. 

PrototypeJS was entirely removed, as well as some dependencides for some specific features (e.g jquery+backbone for router) and all was totally rewritten to use ReactJS.

As a developer point-of-view, it means : 
- That you do have to understand the basics of ReactJS and MVVM concept.
- That you have to properly install npm / grunt when you want to hack
- That the code you will write will follow the ES6 javascript standards
- ... and that the code you will write will be naturally cleaner, better, and more performant :-).

Please read the "Setting up Development Environment" section to learn about the tools required for development.