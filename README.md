# 🎬 TheMovieDB

### 📝 Task Summary
Build an iOS app that fetches remote movie data and displays it on the screen using a clean and modular architecture.

> 📄 _Refer to the task file for more details_

---

### 🧠 Task Analysis

Based on the task requirements, the architecture is broken down into the following major components:

- **Presentation**: Responsible for preparing and displaying data on the UI.
- **Domain**: Implements business rules and application logic.
- **Data**: Handles data fetching, parsing, and persistence.
- **Navigation**: Manages app flow using the Coordinator pattern.

---

### 🏗️ Applied Architecture Pattern: MVX-C (MVP/MVVM + Coordinator) 

After evaluating the requirements, I found **MVX-C** (MVVM or MVP + Coordinator) to be a suitable pattern due to:

- **Presenter / ViewModel**: Effectively separates presentation logic from UI.
- **Testability**: Makes the app easier to unit test and maintain.
- **Coordinator Pattern**: Decouples navigation logic, enabling flexible and reusable views.

> ✅ This project demonstrates both MVP (Presenter) and MVVM (ViewModel) patterns, intentionally combined for educational purposes. The goal is to showcase architectural flexibility and highlight the practical differences between them.  
>  
---

## 🏛 Architecture Overview

> Architecture is not about classes, it's about **responsibilities** and **communication** between components.

### 🎨 Presentation Layer

#### UIKit (MVP Style)
- **View**: Displays data passed from the controller.
- **ViewController**: Binds data to the view and forwards events to the presenter.
- **Presenter**: Handles logic, transforms models into view-friendly data, and triggers use cases.

#### SwiftUI (MVVM Style)
- **View**: Binds to the ViewModel using `@StateObject`.
- **ViewModel**: Fetches and transforms data via use cases for the SwiftUI view.

---

### 🧠 Domain Layer
- **Entity**: Core business models (pure Swift structs).
- **UseCase**: Contains the business logic and operations.
- **Repository Protocols**: Define contracts that abstract data sources (Dependency Inversion Principle).

---

### 💾 Data Layer
- **Repository**: Implements domain contracts, fetching data from remote sources.
- **RemoteDataSource**: Handles API calls and maps responses to DTOs.

---

### 🌐 Network Layer
- **NetworkManager**: Handles the actual decoding of remote data into DTOs.
- **SessionClient**: Executes HTTP requests (GET, POST, etc.) and returns raw responses.

---

## 🚀 Summary

This project is structured to be modular, testable, and scalable. It allows switching between **UIKit (MVP)** and **SwiftUI (MVVM)** without affecting the core business logic — ensuring clean separation of concerns and improved maintainability.

---

