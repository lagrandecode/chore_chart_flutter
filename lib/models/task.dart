class Task {
  final String id;
  final String title;
  final String? description;
  final String assignedToId; // Family member ID
  final bool isCompleted;
  final int points;
  final DateTime? completedAt;
  final DateTime createdAt;

  Task({
    required this.id,
    required this.title,
    this.description,
    required this.assignedToId,
    this.isCompleted = false,
    this.points = 10,
    this.completedAt,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Task copyWith({
    String? id,
    String? title,
    String? description,
    String? assignedToId,
    bool? isCompleted,
    int? points,
    DateTime? completedAt,
    DateTime? createdAt,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      assignedToId: assignedToId ?? this.assignedToId,
      isCompleted: isCompleted ?? this.isCompleted,
      points: points ?? this.points,
      completedAt: completedAt ?? this.completedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

