import 'package:cpudining/packages/exports.dart';

class ReadMoreText extends StatefulWidget {
  final String text;
  final int maxLines;
  const ReadMoreText({super.key, required this.text, required this.maxLines});

  @override
  State<ReadMoreText> createState() => _ReadMoreTextState();
}

class _ReadMoreTextState extends State<ReadMoreText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final textWidget = Text(
      widget.text,
      maxLines: isExpanded ? null : widget.maxLines,
      overflow: TextOverflow.ellipsis,
    );

    final readMoreWidget = GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = false;
        });
      },
      child: const Text(
        'Read More',
        style: TextStyle(color: Colors.blue),
      ),
    );

    final readLessWidget = GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = true;
        });
      },
      child: const Text(
        'Read Less',
        style: TextStyle(color: Colors.blue),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textWidget,
        if (!isExpanded && widget.text.length > widget.maxLines) readLessWidget,
        if (isExpanded) readMoreWidget,
      ],
    );
  }
}
