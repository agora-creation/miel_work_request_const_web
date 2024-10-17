import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:miel_work_request_const_web/common/functions.dart';
import 'package:miel_work_request_const_web/common/style.dart';
import 'package:miel_work_request_const_web/providers/request_const.dart';
import 'package:miel_work_request_const_web/screens/step3.dart';
import 'package:miel_work_request_const_web/widgets/attached_file_list.dart';
import 'package:miel_work_request_const_web/widgets/custom_button.dart';
import 'package:miel_work_request_const_web/widgets/dotted_divider.dart';
import 'package:miel_work_request_const_web/widgets/form_label.dart';
import 'package:miel_work_request_const_web/widgets/form_value.dart';
import 'package:miel_work_request_const_web/widgets/link_text.dart';
import 'package:miel_work_request_const_web/widgets/responsive_box.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path/path.dart' as p;
import 'package:provider/provider.dart';

class Step2Screen extends StatefulWidget {
  final String companyName;
  final String companyUserName;
  final String companyUserEmail;
  final String companyUserTel;
  final String constName;
  final String constUserName;
  final String constUserTel;
  final DateTime constStartedAt;
  final DateTime constEndedAt;
  final bool constAtPending;
  final String constContent;
  final bool noise;
  final String noiseMeasures;
  final bool dust;
  final String dustMeasures;
  final bool fire;
  final String fireMeasures;
  final List<PlatformFile> pickedAttachedFiles;

  const Step2Screen({
    required this.companyName,
    required this.companyUserName,
    required this.companyUserEmail,
    required this.companyUserTel,
    required this.constName,
    required this.constUserName,
    required this.constUserTel,
    required this.constStartedAt,
    required this.constEndedAt,
    required this.constAtPending,
    required this.constContent,
    required this.noise,
    required this.noiseMeasures,
    required this.dust,
    required this.dustMeasures,
    required this.fire,
    required this.fireMeasures,
    required this.pickedAttachedFiles,
    super.key,
  });

  @override
  State<Step2Screen> createState() => _Step2ScreenState();
}

class _Step2ScreenState extends State<Step2Screen> {
  @override
  Widget build(BuildContext context) {
    final constProvider = Provider.of<RequestConstProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 24),
              const Text(
                '店舗工事作業申請フォーム',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SourceHanSansJP-Bold',
                ),
              ),
              const SizedBox(height: 24),
              ResponsiveBox(
                children: [
                  const Text('以下の申請内容で問題ないかご確認ください。'),
                  const SizedBox(height: 16),
                  const DottedDivider(),
                  const SizedBox(height: 16),
                  const Text(
                    '申請者情報',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SourceHanSansJP-Bold',
                    ),
                  ),
                  const SizedBox(height: 8),
                  FormLabel(
                    '店舗名',
                    child: FormValue(widget.constName),
                  ),
                  const SizedBox(height: 8),
                  FormLabel(
                    '店舗責任者名',
                    child: FormValue(widget.companyUserName),
                  ),
                  const SizedBox(height: 8),
                  FormLabel(
                    '店舗責任者メールアドレス',
                    child: FormValue(widget.companyUserEmail),
                  ),
                  const SizedBox(height: 8),
                  FormLabel(
                    '店舗責任者電話番号',
                    child: FormValue(widget.companyUserTel),
                  ),
                  const SizedBox(height: 16),
                  const DottedDivider(),
                  const SizedBox(height: 16),
                  const Text(
                    '工事施工情報',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SourceHanSansJP-Bold',
                    ),
                  ),
                  const SizedBox(height: 8),
                  FormLabel(
                    '工事施工会社名',
                    child: FormValue(widget.constName),
                  ),
                  const SizedBox(height: 8),
                  FormLabel(
                    '工事施工代表者名',
                    child: FormValue(widget.constUserName),
                  ),
                  const SizedBox(height: 8),
                  FormLabel(
                    '工事施工代表者電話番号',
                    child: FormValue(widget.constUserTel),
                  ),
                  const SizedBox(height: 8),
                  FormLabel(
                    '施工予定日時',
                    child: FormValue(
                      widget.constAtPending
                          ? '未定'
                          : '${dateText('yyyy年MM月dd日 HH:mm', widget.constStartedAt)}〜${dateText('yyyy年MM月dd日 HH:mm', widget.constEndedAt)}',
                    ),
                  ),
                  const SizedBox(height: 8),
                  FormLabel(
                    '施工内容',
                    child: FormValue(widget.constContent),
                  ),
                  const SizedBox(height: 8),
                  FormLabel(
                    '騒音',
                    child: FormValue(widget.noise ? '有' : '無'),
                  ),
                  widget.noise
                      ? Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: FormLabel(
                            '騒音対策',
                            child: FormValue(widget.noiseMeasures),
                          ),
                        )
                      : Container(),
                  const SizedBox(height: 8),
                  FormLabel(
                    '粉塵',
                    child: FormValue(widget.dust ? '有' : '無'),
                  ),
                  widget.dust
                      ? Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: FormLabel(
                            '粉塵対策',
                            child: FormValue(widget.dustMeasures),
                          ),
                        )
                      : Container(),
                  const SizedBox(height: 8),
                  FormLabel(
                    '火気の使用',
                    child: FormValue(widget.fire ? '有' : '無'),
                  ),
                  widget.fire
                      ? Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: FormLabel(
                            '火気対策',
                            child: FormValue(widget.fireMeasures),
                          ),
                        )
                      : Container(),
                  const SizedBox(height: 16),
                  const DottedDivider(),
                  const SizedBox(height: 16),
                  FormLabel(
                    '添付ファイル',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: widget.pickedAttachedFiles.map((file) {
                            return AttachedFileList(
                              fileName: p.basename(file.name),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const DottedDivider(),
                  const SizedBox(height: 32),
                  CustomButton(
                    type: ButtonSizeType.lg,
                    label: '上記内容で申請する',
                    labelColor: kWhiteColor,
                    backgroundColor: kBlueColor,
                    onPressed: () async {
                      String? error = await constProvider.create(
                        companyName: widget.constName,
                        companyUserName: widget.companyUserName,
                        companyUserEmail: widget.companyUserEmail,
                        companyUserTel: widget.companyUserTel,
                        constName: widget.constName,
                        constUserName: widget.constUserName,
                        constUserTel: widget.constUserTel,
                        constStartedAt: widget.constStartedAt,
                        constEndedAt: widget.constEndedAt,
                        constAtPending: widget.constAtPending,
                        constContent: widget.constContent,
                        noise: widget.noise,
                        noiseMeasures: widget.noiseMeasures,
                        dust: widget.dust,
                        dustMeasures: widget.dustMeasures,
                        fire: widget.fire,
                        fireMeasures: widget.fireMeasures,
                        pickedAttachedFiles: widget.pickedAttachedFiles,
                      );
                      if (error != null) {
                        if (!mounted) return;
                        showMessage(context, error, false);
                        return;
                      }
                      if (!mounted) return;
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: const Step3Screen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: LinkText(
                      label: '入力に戻る',
                      color: kBlueColor,
                      onTap: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
