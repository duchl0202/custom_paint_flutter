import 'package:flutter/material.dart';
import 'package:flutter_custom_pain/animation/advanced/animation_add_to_card.dart';
import 'package:flutter_custom_pain/animation/basic/multiple_ticker.dart';
import 'package:flutter_custom_pain/animation/basic/qua_cau_bay_va_nay_len.dart';
import 'package:flutter_custom_pain/animation/basic/rotate_transiton.dart';
import 'package:flutter_custom_pain/animation/basic/sequence_animation.dart';
import 'package:flutter_custom_pain/animation/basic/square_loading_animation.dart';
import 'package:flutter_custom_pain/animation/basic/tween_animation_example.dart';
import 'package:flutter_custom_pain/animation/basic/xoay_item_260_do.dart';
import 'package:flutter_custom_pain/animation/nomal/animation_counter.dart';
import 'package:flutter_custom_pain/animation/nomal/animation_load_listview.dart';
import 'package:flutter_custom_pain/animation/nomal/bam_vao_mo_ra.dart';
import 'package:flutter_custom_pain/animation/nomal/interaction_button.dart';
import 'package:flutter_custom_pain/animation/nomal/contdown_wave.dart';
import 'package:flutter_custom_pain/custom_paint/avanced/clock.dart';
import 'package:flutter_custom_pain/custom_paint/avanced/sun_system.dart';
import 'package:flutter_custom_pain/custom_paint/basic/circle.dart';
import 'package:flutter_custom_pain/custom_paint/basic/cloud_painter.dart';
import 'package:flutter_custom_pain/custom_paint/basic/complex_pattern_painter.dart';
import 'package:flutter_custom_pain/custom_paint/basic/ellipse.dart';
import 'package:flutter_custom_pain/custom_paint/basic/japan_flag.dart';
import 'package:flutter_custom_pain/custom_paint/basic/rectangle_gradient.dart';
import 'package:flutter_custom_pain/custom_paint/basic/rounded_square.dart';
import 'package:flutter_custom_pain/custom_paint/basic/smile.dart';
import 'package:flutter_custom_pain/custom_paint/basic/tritager.dart';
import 'package:flutter_custom_pain/custom_paint/normal/duong_zigzag.dart';
import 'package:flutter_custom_pain/custom_paint/normal/half_circle_progress.dart';
import 'package:flutter_custom_pain/custom_paint/normal/half_cirle.dart';
import 'package:flutter_custom_pain/custom_paint/normal/loading_animation.dart';
import 'package:flutter_custom_pain/custom_paint/normal/path_morph.dart';
import 'package:flutter_custom_pain/custom_paint/normal/pentagon.dart';
import 'package:flutter_custom_pain/custom_paint/normal/tooltip.dart';
import 'package:flutter_custom_pain/custom_paint/normal/wave_animation.dart';
import 'package:flutter_custom_pain/gesture_detector/advance/cube_rotating.dart';
import 'package:flutter_custom_pain/gesture_detector/advance/pump_and_balloon.dart';
import 'package:flutter_custom_pain/gesture_detector/normal/swip_card.dart';

enum WidgetType {
  animation,
  customPaint,
  gestureDetector,
}

enum Mode {
  basic,
  intermediate,
  advanced,
}

class WidgetModel {
  final String title;
  final Widget widget;
  final WidgetType type;
  final Mode mode;

  WidgetModel({
    required this.title,
    required this.widget,
    required this.type,
    required this.mode,
  });
}

final widgets = [
  WidgetModel(
    title: 'CloudWidget',
    widget: const CloudWidget(),
    type: WidgetType.customPaint,
    mode: Mode.basic,
  ),
  WidgetModel(
    title: 'ComplexPatternWidget',
    widget: ComplexPatternWidget(),
    type: WidgetType.customPaint,
    mode: Mode.basic,
  ),
  WidgetModel(
    title: 'PentagonWidget',
    widget: PentagonWidget(),
    type: WidgetType.customPaint,
    mode: Mode.intermediate,
  ),
  WidgetModel(
    title: 'RectangleGradientWidget',
    widget: RectangleGradientWidget(),
    type: WidgetType.customPaint,
    mode: Mode.basic,
  ),
  WidgetModel(
    title: 'TriangleWidget',
    widget: const TriangleWidget(),
    type: WidgetType.customPaint,
    mode: Mode.basic,
  ),
  WidgetModel(
    title: 'SmileyWidget',
    widget: const SmileyWidget(),
    type: WidgetType.customPaint,
    mode: Mode.basic,
  ),
  WidgetModel(
    title: 'Path Morph Widget',
    widget: const PathMorphWidget(),
    type: WidgetType.customPaint,
    mode: Mode.intermediate,
  ),
  WidgetModel(
    title: 'Wave Animation',
    widget: WaveAnimation(),
    type: WidgetType.customPaint,
    mode: Mode.intermediate,
  ),
  WidgetModel(
    title: 'DuongZigzagWidget',
    widget: DuongZigzagWidget(),
    type: WidgetType.customPaint,
    mode: Mode.intermediate,
  ),
  WidgetModel(
    title: 'EllipseWidget',
    widget: EllipseWidget(),
    type: WidgetType.customPaint,
    mode: Mode.basic,
  ),
  WidgetModel(
    title: 'RoundedSquareWidget',
    widget: RoundedSquareWidget(),
    type: WidgetType.customPaint,
    mode: Mode.basic,
  ),
  WidgetModel(
    title: 'CircleWidget',
    widget: const CircleWidget(),
    type: WidgetType.customPaint,
    mode: Mode.basic,
  ),
  WidgetModel(
    title: 'JapanFlagWidget',
    widget: const JapanFlagWidget(),
    type: WidgetType.customPaint,
    mode: Mode.basic,
  ),
  WidgetModel(
    title: 'HalfCircleWidget',
    widget: const HalfCircleWidget(),
    type: WidgetType.customPaint,
    mode: Mode.intermediate,
  ),
  WidgetModel(
    title: 'HalfCircleProgressWidget',
    widget: const HalfCircleProgressWidget(),
    type: WidgetType.customPaint,
    mode: Mode.intermediate,
  ),
  WidgetModel(
    title: 'ClockWidget',
    widget: const ClockWidget(),
    type: WidgetType.customPaint,
    mode: Mode.advanced,
  ),
  WidgetModel(
    title: 'SunSystemWidget',
    widget: const SunSystemWidget(),
    type: WidgetType.customPaint,
    mode: Mode.advanced,
  ),
  WidgetModel(
    title: 'TooltipWidget',
    widget: const TooltipWidget(),
    type: WidgetType.customPaint,
    mode: Mode.intermediate,
  ),
  WidgetModel(
    title: 'QuaCauBayVaNayLen',
    widget: QuaCauBayVaNayLen(),
    type: WidgetType.animation,
    mode: Mode.basic,
  ),
  WidgetModel(
    title: 'AnimatedFlipCounter',
    widget: CounterPage(),
    type: WidgetType.animation,
    mode: Mode.intermediate,
  ),
  WidgetModel(
    title: 'SwipeCardDemo',
    widget: SwipeCardDemo(),
    type: WidgetType.gestureDetector,
    mode: Mode.intermediate,
  ),
  WidgetModel(
    title: 'RotatingImage',
    widget: RotatingImage(),
    type: WidgetType.animation,
    mode: Mode.basic,
  ),
  WidgetModel(
    title: 'AnimatedListExample',
    widget: AnimatedListExample(),
    type: WidgetType.animation,
    mode: Mode.intermediate,
  ),
  WidgetModel(
    title: 'AnimatedListExample',
    widget: AnimatedListAddToCard(),
    type: WidgetType.animation,
    mode: Mode.advanced,
  ),
  WidgetModel(
    title: 'CubeRotating',
    widget: CubeRotating(),
    type: WidgetType.gestureDetector,
    mode: Mode.advanced,
  ),
  WidgetModel(
    title: 'LoadingAnimationWidget',
    widget: LoadingAnimationWidget(),
    type: WidgetType.customPaint,
    mode: Mode.intermediate,
  ),
  WidgetModel(
    title: 'PumpAndBalloon',
    widget: PumpAndBalloon(),
    type: WidgetType.gestureDetector,
    mode: Mode.advanced,
  ),
  WidgetModel(
    title: 'TweenAnimation',
    widget: TweenAnimationExample(),
    type: WidgetType.animation,
    mode: Mode.basic,
  ),
  WidgetModel(
    title: 'SequenceAnimation',
    widget: SequenceAnimationExample(),
    type: WidgetType.animation,
    mode: Mode.basic,
  ),
  WidgetModel(
    title: 'RotateTransition',
    widget: RotateTransitionExample(),
    type: WidgetType.animation,
    mode: Mode.basic,
  ),
  WidgetModel(
    title: 'MultipleTicker',
    widget: MultipleTicker(),
    type: WidgetType.animation,
    mode: Mode.basic,
  ),
  WidgetModel(
    title: 'Square Loading Animation',
    widget: SquareLoadingAnimation(),
    type: WidgetType.animation,
    mode: Mode.intermediate,
  ),
  WidgetModel(
    title: 'Bấm vào mở ra',
    widget: BamVaoMoRa(),
    type: WidgetType.animation,
    mode: Mode.intermediate,
  ),
  WidgetModel(
    title: 'Hiệu ứng Gradient Button',
    widget: InteractionButton(),
    type: WidgetType.animation,
    mode: Mode.intermediate,
  ),
  WidgetModel(
    title: 'Hiệu ứng sóng đồng hồ',
    widget: CountdownScreen(),
    type: WidgetType.animation,
    mode: Mode.intermediate,
  ),
];
