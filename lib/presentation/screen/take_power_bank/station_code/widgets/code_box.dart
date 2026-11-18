import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nurbox/core/ui/colors/app_colors.dart';

class CodeInputBoxes extends StatefulWidget {
  const CodeInputBoxes({super.key, this.length = 6, this.onChanged});

  final int length;

  /// Вызывается при каждом изменении кода.
  final ValueChanged<String>? onChanged;

  @override
  State<CodeInputBoxes> createState() => _CodeInputBoxesState();
}

class _CodeInputBoxesState extends State<CodeInputBoxes> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _openKeyboard() {
    if (_focusNode.hasFocus) {
      SystemChannels.textInput.invokeMethod('TextInput.show');
    } else {
      _focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _openKeyboard,
      child: Stack(
        children: [
          ListenableBuilder(
            listenable: Listenable.merge([_controller, _focusNode]),
            builder: (context, _) {
              final text = _controller.text;
              final activeIndex = text.length.clamp(0, widget.length - 1);
              return Row(
                children: [
                  for (var i = 0; i < widget.length; i++) ...[
                    if (i != 0) const SizedBox(width: 8),
                    Expanded(
                      child: _CodeBox(
                        char: i < text.length ? text[i] : '',
                        isActive: _focusNode.hasFocus && i == activeIndex,
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
          // Скрытое поле ввода
          Positioned(
            left: 0,
            top: 0,
            child: Opacity(
              opacity: 0,
              child: SizedBox(
                width: 1,
                height: 1,
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  autofocus: true,
                  showCursor: false,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(widget.length),
                  ],
                  onChanged: widget.onChanged,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    counterText: '',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CodeBox extends StatelessWidget {
  const _CodeBox({required this.char, required this.isActive});

  final String char;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      height: 56,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isActive ? AppColors.primaryText : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: Text(
        char,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: AppColors.primaryText,
        ),
      ),
    );
  }
}
