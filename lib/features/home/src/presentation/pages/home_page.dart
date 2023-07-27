import 'package:fale_baby_app/core/mixins/app_mixin.dart';
import 'package:fale_baby_app/core/widget/app_stateful_widget.dart';
import 'package:fale_baby_app/features/questions/question.dart';
import 'package:fale_baby_design_system/design_system.dart';
import 'package:flutter/material.dart';

class Home extends AppStateFulWidget {
  static const name = '/home';

  Home({
    Key? key,
    String? widgetName,
    int? id,
  }) : super(
          key: key,
          className: name,
          id: id,
          widgetName: widgetName,
        );

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with AppWidgetMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorNeutral10,
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 100,
          vertical: 134,
        ),
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('assets/images/bg-home.png'),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Image.asset('assets/images/logo-sm.png'),
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    'assets/images/logo-sm.png',
                  ),
                ),
              ),
              height: 124,
              width: 193,
            ),
            const VGap.xxxs(),
            Text(
              'Olá, bem-vindo(a) ao Fale Baby',
              style: context.typography.h3Medium.copyWith(
                color: kColorBrandPrimary,
              ),
            ),
            const VGap.nano(),
            Text(
              'O que deseja fazer',
              style: context.typography.titleMedium.copyWith(
                color: kColorBrandPrimary,
              ),
            ),
            const VGap.xxl(),
            Row(
              children: [
                Expanded(
                  child: _MenuAction(
                    icon: const DSIcon.analyse(),
                    label: 'Nova análise',
                    onTap: () => navigator.toNamed(routeName: QuestionsPage.name),
                  ),
                ),
                const HGap.xxs(),
                Expanded(
                  child: _MenuAction(
                    icon: const DSIcon.baby(),
                    label: 'Lista de Bebês',
                    onTap: () {},
                  ),
                ),
                const HGap.xxs(),
                Expanded(
                  child: _MenuAction(
                    icon: const DSIcon.babyAdd(),
                    label: 'Cadastrar Bebê',
                    onTap: () {},
                  ),
                ),
                const HGap.xxs(),
                Expanded(
                  child: _MenuAction(
                    icon: const DSIcon.config(),
                    label: 'Dados',
                    onTap: () {},
                  ),
                ),
              ],
            ),
            const VGap.xl(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DSButton.onOutlined(
                  label: 'Sobre o <bold>Fale Baby</bold>',
                  onTap: () {},
                ),
                const HGap.xxxs(),
                DSButton(
                  label: 'Ver <bold>instruções</bold>',
                  onTap: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _MenuAction extends StatefulWidget {
  final DSIcon icon;
  final String label;
  final VoidCallback onTap;

  const _MenuAction({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  State<_MenuAction> createState() => _MenuActionState();
}

class _MenuActionState extends State<_MenuAction> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kSpacingInlineSM,
            vertical: kSpacingStackSM,
          ),
          child: Column(
            children: [
              widget.icon.copyWith(
                color: kColorBrandPrimary,
                size: kIconSizeXXXL,
              ),
              const VGap.xs(),
              Text(
                widget.label,
                style: context.typography.h4Medium.copyWith(
                  color: kColorBrandPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
