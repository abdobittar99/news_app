part of 'onboarding_cubit.dart';

class OnboardingState extends Equatable {
  const OnboardingState({this.currentIndex = 0, this.islastPage = false});
  final int currentIndex;
  final bool islastPage;

  OnboardingState copyWith({int? currentIndex, bool? islastPage}) {
    return OnboardingState(
      currentIndex: currentIndex ?? this.currentIndex,
      islastPage: islastPage ?? this.islastPage,
    );
  }

  @override
  List<Object> get props => [currentIndex, islastPage];
}
