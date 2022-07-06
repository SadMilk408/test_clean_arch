import 'package:clean_arch/features/number_trivia/domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia {
  const NumberTriviaModel({required String text, required int number})
      : super(text: text, number: number);

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) {
    if (json['text'] != null && json['number'] != null) {
      return NumberTriviaModel(
        text: json['text'],
        number: (json['number'] as num).toInt(),
      );
    } else {
      return const NumberTriviaModel(
        text: 'Model have null',
        number: 0,
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'number': number,
    };
  }
}
