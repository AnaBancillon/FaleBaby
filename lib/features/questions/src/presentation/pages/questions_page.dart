import 'package:fale_baby_app/core/mixins/app_mixin.dart';
import 'package:fale_baby_app/core/widget/app_stateful_widget.dart';
import 'package:fale_baby_app/utils/responsive_utils.dart';
import 'package:fale_baby_design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class QuestionsPage extends AppStateFulWidget {
  static const name = '/questions';

  QuestionsPage({
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
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> with AppWidgetMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorNeutral10,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 100,
                vertical: 134,
              ),
              color: kColorNeutral10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 85,
                    width: 132,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/logo-sm.png',
                        ),
                      ),
                    ),
                  ),
                  const VGap.sm(),
                  Text(
                    'Item 3 de 25',
                    style: context.typography.bodyRegular.copyWith(
                      color: kColorBlue90,
                    ),
                  ),
                  const VGap.nano(),
                  Text(
                    'Pedro geralmente procura os objetos que você esconde durante uma brincadeira?',
                    style: context.typography.h4Medium.copyWith(
                      color: kColorBrandPrimary,
                    ),
                  ),
                  const VGap.xxxs(),
                  Text(
                    'Geralmente alcançado entre 6 e 8 meses de idade',
                    style: context.typography.bodyRegular.copyWith(
                      color: kColorBrandPrimary,
                    ),
                  ),
                  const VGap.lg(),
                  Row(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: kSpacingInlineXXXS,
                            vertical: kSpacingStackXXXS,
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: const Icon(
                                  Icons.radio_button_unchecked,
                                  color: kColorBlue60,
                                  size: kIconSizeSM,
                                ),
                              ),
                              const HGap.xxxs(),
                              Text(
                                'Sim',
                                style: context.typography.labelRegular.copyWith(
                                  color: kColorBrandPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const HGap.xs(),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: kSpacingInlineXXXS,
                            vertical: kSpacingStackXXXS,
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: const Icon(
                                  Icons.radio_button_unchecked,
                                  color: kColorBlue60,
                                  size: kIconSizeSM,
                                ),
                              ),
                              const HGap.xxxs(),
                              Text(
                                'Não',
                                style: context.typography.labelRegular.copyWith(
                                  color: kColorBrandPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const VGap.xl(),
                  Row(
                    children: [
                      DSTextButton.onDark(
                        label: 'Voltar',
                        onTap: () {},
                      ),
                      const HGap.md(),
                      DSButton(
                        label: '<bold>Avançar</bold>',
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: kSpacingInlineXS,
              vertical: 134,
            ),
            width: MediaQuery.of(context).size.width * 0.2,
            decoration: BoxDecoration(
              color: kColorNeutral00,
              boxShadow: [
                kBoxShadowLevel1,
                kBoxShadowLevel2,
                kBoxShadowLevel4,
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircularPercentIndicator(
                  backgroundColor: kColorNeutral20,
                  radius: 60.0,
                  lineWidth: 10.0,
                  percent: 0.3,
                  center: Text(
                    "20%",
                    style: context.typography.h4Bold,
                  ),
                  progressColor: kColorBrandPrimary,
                ),
                const VGap.xxs(),
                Text(
                  'Análise',
                  style: context.typography.titleMedium,
                ),
                const VGap.nano(),
                Text(
                  'Pedro Luiz Oliveira',
                  style: context.typography.h4Medium,
                ),
                const VGap.nano(),
                Text(
                  '1 ano e 6 meses',
                  style: context.typography.bodyRegular,
                ),
                const Spacer(),
                DSSmallButton.onOutlined(
                  label: "<bold>Sair</bold>",
                  onTap: navigator.pop,
                ),`
              ],
            ),
          ),
        ],
      ),
    );
  }
}
