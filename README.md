# 🎓 Unitrack - Education Portal App

> A Flutter-powered student-teacher portal that brings classroom management, communication, and real-world DSA into one seamless mobile experience.

---

## 🌟 Overview

Unitrack is a cross-platform mobile app built with Flutter and Supabase, designed to streamline communication and management between students and teachers. What makes it unique is the intentional application of core data structures and algorithms — not in a textbook exercise, but in a live, usable product that solves real problems for real users.

Most DSA projects are done using Python scripts or JavaFX desktop apps. Unitrack takes a different approach: bringing efficient algorithms into a mobile-first portal that students and teachers can access anytime, anywhere.

---

## ✨ Features

### 👨‍🎓 For Students
- Track assignments and submission deadlines
- View class schedules at a glance
- Receive real-time notifications from teachers
- Access uploaded learning materials

### 👩‍🏫 For Teachers
- Manage classes and student rosters
- Upload and organize course materials
- Monitor student progress and performance
- Send announcements and updates instantly

### ⚙️ Under the Hood
- **DSA-powered attendance tracking** — efficient data structures for fast lookup and history management
- **Optimized assignment management** — algorithmic sorting and filtering for deadline-aware queues
- **Real-time sync** — live updates via Supabase Realtime for instant classroom communication

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter / Dart |
| Backend | Supabase |
| Authentication | Supabase Auth |
| Database | Supabase PostgreSQL |
| Real-Time | Supabase Realtime |
| Core Logic | Custom DSA implementations (Dart) |

---

## 📸 Screenshots

<img width="6000" height="4003" alt="portal" src="https://github.com/user-attachments/assets/6299d70d-551e-47e9-856d-8a178ff42489" />

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK `>=3.0.0`
- Dart `>=3.0.0`
- A [Supabase](https://supabase.com) project with URL and anon key

### Installation

```bash
# Clone the repository
git clone https://github.com/aamirali65/Unitrack-EduPortalApp

# Navigate to the project directory
cd unitrack

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### Supabase Configuration

Create a `.env` file or update `lib/config/supabase_config.dart`:

```dart
const String supabaseUrl = 'https://your-project.supabase.co';
const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';
```

> ⚠️ Never commit your Supabase keys to version control. Add `.env` to your `.gitignore`.

---

## 🧠 DSA in Practice

One of the core motivations behind Unitrack was applying data structures and algorithms in a real-world mobile context — something rarely seen outside of Python scripts or JavaFX desktop projects.

| Feature | DSA Applied |
|---|---|
| Attendance Tracking | Hash maps for O(1) student lookup; arrays for historical records |
| Assignment Deadlines | Priority queue (min-heap) for deadline-sorted task management |
| Schedule Display | Sorting algorithms for ordered, conflict-free timetable rendering |
| Notifications | Queue-based event dispatch for ordered delivery |

This makes Unitrack both a functional product and a practical demonstration that DSA concepts have a natural home in mobile development.

---

## 🗺️ Roadmap

- [ ] In-app messaging between students and teachers
- [ ] Grade tracking and GPA calculator
- [ ] Assignment submission with file upload
- [ ] Analytics dashboard for teacher insights
- [ ] Push notifications via FCM
- [ ] Offline mode with local caching

---

## 🔗 Repository

**GitHub:** (https://github.com/aamirali65/Unitrack-EduPortalApp/)

> 🚧 This project is actively in development. Feedback and ideas are always welcome!

---

## 🤝 Contributing

Have a feature idea or found a bug? Open an issue or submit a pull request — contributions are very welcome.

1. Fork the project
2. Create your feature branch: `git checkout -b feature/your-feature`
3. Commit your changes: `git commit -m 'Add some feature'`
4. Push to the branch: `git push origin feature/your-feature`
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## 👤 Author

**Aamir Ali**
- Email: [contact.aamirali65@gmail.com](mailto:contact.aamirali65@gmail.com)
- GitHub: [@your-username](https://github.com/aamirali65)
- LinkedIn: [your-linkedin](https://linkedin.com/in/aamirali65)

---

> *Unitrack started as a DSA project — and grew into a full mobile app that students and teachers can actually use. That's the kind of engineering I want to keep building.*
