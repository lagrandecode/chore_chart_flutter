import 'package:flutter/material.dart';
import '../models/family_member.dart';
import '../models/task.dart';
import '../theme/crayon_theme.dart';
import '../widgets/crayon_avatar.dart';
import '../widgets/wiggly_checkbox.dart';
import '../widgets/star_sticker.dart';
import '../widgets/weekly_progress_chart.dart';
import '../painters/paper_texture_painter.dart';
import '../painters/wobbly_border_painter.dart';

class ChoreChartScreen extends StatefulWidget {
  const ChoreChartScreen({super.key});

  @override
  State<ChoreChartScreen> createState() => _ChoreChartScreenState();
}

class _ChoreChartScreenState extends State<ChoreChartScreen> {
  final List<FamilyMember> _familyMembers = [
    FamilyMember(
      id: '1',
      name: 'Mom',
      avatarColor: CrayonTheme.brickRed,
      points: 45,
      avatarShape: 'circle',
    ),
    FamilyMember(
      id: '2',
      name: 'Dad',
      avatarColor: CrayonTheme.forestGreen,
      points: 38,
      avatarShape: 'square',
    ),
    FamilyMember(
      id: '3',
      name: 'Emma',
      avatarColor: CrayonTheme.mustardYellow,
      points: 52,
      avatarShape: 'circle',
    ),
    FamilyMember(
      id: '4',
      name: 'Jake',
      avatarColor: CrayonTheme.softGreen,
      points: 41,
      avatarShape: 'triangle',
    ),
  ];

  final List<Task> _tasks = [
    Task(
      id: '1',
      title: 'Make bed',
      assignedToId: '3',
      points: 5,
      isCompleted: true,
      completedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Task(
      id: '2',
      title: 'Take out trash',
      assignedToId: '4',
      points: 10,
      isCompleted: true,
      completedAt: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    Task(
      id: '3',
      title: 'Do dishes',
      assignedToId: '3',
      points: 10,
    ),
    Task(
      id: '4',
      title: 'Clean room',
      assignedToId: '4',
      points: 15,
    ),
    Task(
      id: '5',
      title: 'Feed pet',
      assignedToId: '1',
      points: 5,
      isCompleted: true,
      completedAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Task(
      id: '6',
      title: 'Set table',
      assignedToId: '3',
      points: 5,
    ),
  ];

  FamilyMember? _selectedMember;

  @override
  void initState() {
    super.initState();
    _selectedMember = _familyMembers.first;
  }

  Map<String, int> get _weeklyProgress {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final progress = <String, int>{};
    
    for (int i = 0; i < 7; i++) {
      final day = weekStart.add(Duration(days: i));
      final dayName = days[day.weekday - 1];
      progress[dayName] = _tasks.where((task) {
        return task.isCompleted &&
            task.completedAt != null &&
            task.completedAt!.year == day.year &&
            task.completedAt!.month == day.month &&
            task.completedAt!.day == day.day;
      }).length;
    }
    
    return progress;
  }

  void _toggleTask(Task task) {
    setState(() {
      final index = _tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        _tasks[index] = task.copyWith(
          isCompleted: !task.isCompleted,
          completedAt: !task.isCompleted ? DateTime.now() : null,
        );
        
        // Update points for the family member
        if (!task.isCompleted) {
          final memberIndex = _familyMembers.indexWhere((m) => m.id == task.assignedToId);
          if (memberIndex != -1) {
            _familyMembers[memberIndex] = _familyMembers[memberIndex].copyWith(
              points: _familyMembers[memberIndex].points + task.points,
            );
          }
        }
      }
    });
  }

  FamilyMember _getMemberById(String id) {
    return _familyMembers.firstWhere((m) => m.id == id);
  }

  List<Task> get _filteredTasks {
    if (_selectedMember == null) return _tasks;
    return _tasks.where((task) => task.assignedToId == _selectedMember!.id).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: PaperTexturePainter(),
        child: Container(
          decoration: BoxDecoration(color: CrayonTheme.lightCream),
          child: SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Our Chore Chart',
                    style: CrayonTheme.childlikeBold.copyWith(
                      fontSize: 32,
                      color: CrayonTheme.darkBrown,
                    ),
                  ),
                ),
                
                // Family members selector
                SizedBox(
                  height: 110,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _familyMembers.length,
                    itemBuilder: (context, index) {
                      final member = _familyMembers[index];
                      final isSelected = _selectedMember?.id == member.id;
                      
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedMember = member;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isSelected
                                          ? CrayonTheme.mustardYellow.withOpacity(0.3)
                                          : Colors.transparent,
                                    ),
                                    child: CrayonAvatar(
                                      member: member,
                                      size: 55,
                                    ),
                                  ),
                                  if (isSelected)
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: Container(
                                        width: 18,
                                        height: 18,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: CrayonTheme.mustardYellow,
                                        ),
                                        child: const Icon(
                                          Icons.check,
                                          size: 12,
                                          color: CrayonTheme.darkBrown,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 3),
                              Text(
                                member.name,
                                style: CrayonTheme.childlikeSmall.copyWith(fontSize: 12),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  StarSticker(size: 14, shiny: false),
                                  const SizedBox(width: 3),
                                  Text(
                                    '${member.points}',
                                    style: CrayonTheme.childlikeSmall.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Tasks list
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      Text(
                        _selectedMember != null
                            ? '${_selectedMember!.name}\'s Tasks'
                            : 'All Tasks',
                        style: CrayonTheme.childlikeBold.copyWith(fontSize: 24),
                      ),
                      const SizedBox(height: 16),
                      ..._filteredTasks.map((task) {
                        final member = _getMemberById(task.assignedToId);
                        return _TaskCard(
                          task: task,
                          member: member,
                          onToggle: () => _toggleTask(task),
                        );
                      }),
                      const SizedBox(height: 20),
                      
                      // Weekly progress chart
                      CustomPaint(
                        painter: WobblyBorderPainter(
                          color: CrayonTheme.darkBrown,
                          strokeWidth: 3.0,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: CrayonTheme.cream.withOpacity(0.5),
                          ),
                          child: WeeklyProgressChart(
                            dailyProgress: _weeklyProgress,
                            maxTasks: 10,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  final Task task;
  final FamilyMember member;
  final VoidCallback onToggle;

  const _TaskCard({
    required this.task,
    required this.member,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: CustomPaint(
        painter: WobblyBorderPainter(
          color: CrayonTheme.darkBrown,
          strokeWidth: 2.5,
          wobbleAmount: 3.0,
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: CrayonTheme.cream.withOpacity(0.6),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              WigglyCheckbox(
                value: task.isCompleted,
                onChanged: (_) => onToggle(),
                size: 32,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: CrayonTheme.childlikeText.copyWith(
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                        color: task.isCompleted
                            ? CrayonTheme.darkBrown.withOpacity(0.5)
                            : CrayonTheme.darkBrown,
                      ),
                    ),
                    if (task.description != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        task.description!,
                        style: CrayonTheme.childlikeSmall,
                      ),
                    ],
                  ],
                ),
              ),
              if (task.isCompleted) ...[
                const SizedBox(width: 8),
                const StarSticker(size: 32, shiny: true),
              ] else ...[
                const SizedBox(width: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    StarSticker(size: 20, shiny: false),
                    const SizedBox(width: 4),
                    Text(
                      '+${task.points}',
                      style: CrayonTheme.childlikeSmall.copyWith(
                        fontWeight: FontWeight.bold,
                        color: CrayonTheme.forestGreen,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

