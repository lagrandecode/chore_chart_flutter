# 🎨 Chore Chart - Crayon Aesthetic Family Task Manager

A delightful Flutter mobile app for managing family chores with a warm, nostalgic crayon-drawn aesthetic. Built with custom hand-drawn UI elements that bring back the arts-and-crafts energy of childhood.

![Flutter](https://img.shields.io/badge/Flutter-3.35.7-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.9.2-0175C2?logo=dart)

## 📸 Screenshot

![Chore Chart App Screenshot](assets/images/Simulator%20Screenshot%20-%20iPhone%2016e%20-%202026-01-02%20at%2019.10.09.png)

*The app features a warm crayon aesthetic with wobbly borders, hand-drawn avatars, and a nostalgic paper texture background.*

## ✨ Features

### 🎨 Visual Design
- **Warm Earthy Palette**: Forest green, mustard yellow, brick red, and cream colors
- **Crayon Texture Strokes**: Custom-painted UI elements with hand-drawn aesthetics
- **Wobbly Hand-Drawn Borders**: Irregular, childlike borders throughout the app
- **Paper Texture Background**: Subtle paper grain texture for a nostalgic feel
- **Rounded Childlike Typography**: Friendly, approachable text styles

### 👨‍👩‍👧‍👦 Family Management
- **Cute Crayon-Drawn Avatars**: Custom illustrated family member avatars
- **Multiple Avatar Shapes**: Circle, square, and triangle shapes for variety
- **Family Member Selection**: Tap to filter tasks by family member
- **Reward Points System**: Track points for each family member

### ✅ Task Management
- **Wiggly Checkbox Doodles**: Hand-drawn, wobbly checkboxes for tasks
- **Task Assignment**: Assign tasks to specific family members
- **Task Completion**: Toggle tasks with satisfying visual feedback
- **Points per Task**: Different tasks award different point values

### ⭐ Rewards & Progress
- **Gold Star Stickers**: Shiny star illustrations appear on completed tasks
- **Weekly Progress Chart**: Colorful scribbled bar chart showing daily task completion
- **Points Display**: Visual star icons with point counts

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.35.7 or higher)
- Dart SDK (3.9.2 or higher)
- iOS Simulator/Android Emulator or physical device

### Installation

1. **Clone the repository** (or navigate to the project directory)
   ```bash
   cd chore_chart
   ```

2. **Get dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Building for Production

**iOS:**
```bash
flutter build ios
```

**Android:**
```bash
flutter build apk
# or for app bundle:
flutter build appbundle
```

## 📱 App Structure

```
lib/
├── main.dart                    # App entry point
├── models/
│   ├── family_member.dart      # Family member data model
│   └── task.dart               # Task data model
├── screens/
│   └── chore_chart_screen.dart # Main chore chart screen
├── widgets/
│   ├── crayon_avatar.dart      # Custom crayon-drawn avatar widget
│   ├── wiggly_checkbox.dart    # Hand-drawn checkbox widget
│   ├── star_sticker.dart       # Gold star sticker widget
│   └── weekly_progress_chart.dart # Scribbled progress chart
├── painters/
│   ├── paper_texture_painter.dart  # Paper texture background
│   ├── wobbly_border_painter.dart  # Wobbly border painter
│   └── crayon_stroke_painter.dart  # Crayon stroke effects
└── theme/
    └── crayon_theme.dart       # Color palette and theme constants
```

## 🎨 Design Philosophy

This app embraces a **Storybook Crayon aesthetic** with:

- **Warm, Nostalgic Feel**: Reminiscent of childhood arts and crafts
- **Hand-Drawn Elements**: All UI components are custom-painted to look hand-drawn
- **Playful Interaction**: Wobbly borders, wiggly checkboxes, and scribbled charts
- **Family-Friendly**: Designed to make chore tracking fun for the whole family

## 🔧 Customization

### Adding Family Members

Edit the `_familyMembers` list in `lib/screens/chore_chart_screen.dart`:

```dart
FamilyMember(
  id: 'unique-id',
  name: 'Member Name',
  avatarColor: CrayonTheme.forestGreen, // Choose from theme colors
  points: 0,
  avatarShape: 'circle', // 'circle', 'square', or 'triangle'
)
```

### Adding Tasks

Edit the `_tasks` list in `lib/screens/chore_chart_screen.dart`:

```dart
Task(
  id: 'unique-id',
  title: 'Task Name',
  assignedToId: 'family-member-id',
  points: 10,
  isCompleted: false,
)
```

### Customizing Colors

Edit `lib/theme/crayon_theme.dart` to change the color palette:

```dart
static const Color forestGreen = Color(0xFF2D5016);
static const Color mustardYellow = Color(0xFFE6B800);
static const Color brickRed = Color(0xFFB85450);
static const Color cream = Color(0xFFFFF8E7);
```

## 📋 Sample Data

The app comes pre-loaded with sample data:

- **4 Family Members**: Mom, Dad, Emma, and Jake
- **6 Sample Tasks**: Various household chores with different point values
- **Weekly Progress**: Mock data showing task completion patterns

## 🛠️ Technologies Used

- **Flutter**: Cross-platform UI framework
- **Custom Painters**: Custom `CustomPainter` classes for hand-drawn effects
- **State Management**: Flutter's built-in `StatefulWidget` and `setState`

## 📝 Notes

- All visual elements (avatars, stars, checkboxes, borders) are created programmatically using Flutter's `CustomPainter` - no external image assets required!
- The wobbly borders and hand-drawn effects use randomized offsets to create the irregular, childlike appearance
- The paper texture background adds depth without being distracting

## 🤝 Contributing

This is a personal project, but feel free to fork and customize it for your family!

## 📄 License

This project is open source and available for personal use.

## 🙏 Acknowledgments

- Inspired by the warmth of childhood arts and crafts
- Designed to make household chore management more engaging and fun

---

Made with ❤️ and lots of crayons 🖍️
