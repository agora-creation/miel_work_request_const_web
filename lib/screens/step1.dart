import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:miel_work_request_const_web/common/custom_date_time_picker.dart';
import 'package:miel_work_request_const_web/common/functions.dart';
import 'package:miel_work_request_const_web/common/style.dart';
import 'package:miel_work_request_const_web/providers/request_const.dart';
import 'package:miel_work_request_const_web/screens/step2.dart';
import 'package:miel_work_request_const_web/widgets/attached_file_list.dart';
import 'package:miel_work_request_const_web/widgets/custom_button.dart';
import 'package:miel_work_request_const_web/widgets/custom_checkbox.dart';
import 'package:miel_work_request_const_web/widgets/custom_text_field.dart';
import 'package:miel_work_request_const_web/widgets/datetime_range_form.dart';
import 'package:miel_work_request_const_web/widgets/dotted_divider.dart';
import 'package:miel_work_request_const_web/widgets/form_label.dart';
import 'package:miel_work_request_const_web/widgets/responsive_box.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path/path.dart' as p;
import 'package:provider/provider.dart';

class Step1Screen extends StatefulWidget {
  const Step1Screen({super.key});

  @override
  State<Step1Screen> createState() => _Step1ScreenState();
}

class _Step1ScreenState extends State<Step1Screen> {
  TextEditingController companyName = TextEditingController();
  TextEditingController companyUserName = TextEditingController();
  TextEditingController companyUserEmail = TextEditingController();
  TextEditingController companyUserTel = TextEditingController();
  TextEditingController constName = TextEditingController();
  TextEditingController constUserName = TextEditingController();
  TextEditingController constUserTel = TextEditingController();
  DateTime constStartedAt = DateTime.now();
  DateTime constEndedAt = DateTime.now();
  bool constAtPending = false;
  TextEditingController constContent = TextEditingController();
  bool noise = false;
  TextEditingController noiseMeasures = TextEditingController();
  bool dust = false;
  TextEditingController dustMeasures = TextEditingController();
  bool fire = false;
  TextEditingController fireMeasures = TextEditingController();
  List<PlatformFile> pickedAttachedFiles = [];

  @override
  void initState() {
    constStartedAt = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      10,
      0,
      0,
    );
    constEndedAt = constStartedAt.add(
      const Duration(hours: 2),
    );
    super.initState();
  }

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
                  const Text('以下のフォームにご入力いただき、申請を行なってください。'),
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
                    required: true,
                    child: CustomTextField(
                      controller: companyName,
                      textInputType: TextInputType.text,
                      maxLines: 1,
                      hintText: '例）明神水産',
                    ),
                  ),
                  const SizedBox(height: 8),
                  FormLabel(
                    '店舗責任者名',
                    required: true,
                    child: CustomTextField(
                      controller: companyUserName,
                      textInputType: TextInputType.text,
                      maxLines: 1,
                      hintText: '例）田中太郎',
                    ),
                  ),
                  const SizedBox(height: 8),
                  FormLabel(
                    '店舗責任者メールアドレス',
                    required: true,
                    child: CustomTextField(
                      controller: companyUserEmail,
                      textInputType: TextInputType.text,
                      maxLines: 1,
                      hintText: '例）tanaka@hirome.co.jp',
                    ),
                  ),
                  const Text(
                    '※このメールアドレス宛に、返答させていただきます',
                    style: TextStyle(
                      color: kRedColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SourceHanSansJP-Bold',
                    ),
                  ),
                  const SizedBox(height: 8),
                  FormLabel(
                    '店舗責任者電話番号',
                    required: true,
                    child: CustomTextField(
                      controller: companyUserTel,
                      textInputType: TextInputType.text,
                      maxLines: 1,
                      hintText: '例）090-0000-0000',
                    ),
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
                    child: CustomTextField(
                      controller: constName,
                      textInputType: TextInputType.text,
                      maxLines: 1,
                      hintText: '例）株式会社ABC',
                    ),
                  ),
                  const Text(
                    '※施工の管理ができる業者',
                    style: TextStyle(
                      color: kRedColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SourceHanSansJP-Bold',
                    ),
                  ),
                  const SizedBox(height: 8),
                  FormLabel(
                    '工事施工代表者名',
                    child: CustomTextField(
                      controller: constUserName,
                      textInputType: TextInputType.text,
                      maxLines: 1,
                      hintText: '例）山田二郎',
                    ),
                  ),
                  const SizedBox(height: 8),
                  FormLabel(
                    '工事施工代表者電話番号',
                    child: CustomTextField(
                      controller: constUserTel,
                      textInputType: TextInputType.text,
                      maxLines: 1,
                      hintText: '例）090-0000-0000',
                    ),
                  ),
                  const SizedBox(height: 8),
                  FormLabel(
                    '施工予定日時',
                    child: DatetimeRangeForm(
                      startedAt: constStartedAt,
                      startedOnTap: () async =>
                          await CustomDateTimePicker().picker(
                        context: context,
                        init: constStartedAt,
                        title: '施工予定開始日時を選択',
                        onChanged: (value) {
                          setState(() {
                            constStartedAt = value;
                          });
                        },
                      ),
                      endedAt: constEndedAt,
                      endedOnTap: () async =>
                          await CustomDateTimePicker().picker(
                        context: context,
                        init: constEndedAt,
                        title: '施工予定終了日時を選択',
                        onChanged: (value) {
                          setState(() {
                            constEndedAt = value;
                          });
                        },
                      ),
                      pending: constAtPending,
                      pendingOnChanged: (value) {
                        setState(() {
                          constAtPending = value ?? false;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  FormLabel(
                    '施工内容',
                    child: CustomTextField(
                      controller: constContent,
                      textInputType: TextInputType.multiline,
                      maxLines: 5,
                    ),
                  ),
                  const Text(
                    '※工程表ファイルも、下の添付ファイルから送ってください',
                    style: TextStyle(
                      color: kRedColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SourceHanSansJP-Bold',
                    ),
                  ),
                  const SizedBox(height: 8),
                  FormLabel(
                    '騒音',
                    child: CustomCheckbox(
                      label: '有る場合はチェックを入れてください',
                      value: noise,
                      onChanged: (value) {
                        setState(() {
                          noise = value ?? false;
                        });
                      },
                      borderView: true,
                    ),
                  ),
                  noise
                      ? Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: FormLabel(
                            '騒音対策',
                            child: CustomTextField(
                              controller: noiseMeasures,
                              textInputType: TextInputType.text,
                              maxLines: 1,
                            ),
                          ),
                        )
                      : Container(),
                  const SizedBox(height: 8),
                  FormLabel(
                    '粉塵',
                    child: CustomCheckbox(
                      label: '有る場合はチェックを入れてください',
                      value: dust,
                      onChanged: (value) {
                        setState(() {
                          dust = value ?? false;
                        });
                      },
                      borderView: true,
                    ),
                  ),
                  dust
                      ? Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: FormLabel(
                            '粉塵対策',
                            child: CustomTextField(
                              controller: dustMeasures,
                              textInputType: TextInputType.text,
                              maxLines: 1,
                            ),
                          ),
                        )
                      : Container(),
                  const SizedBox(height: 8),
                  FormLabel(
                    '火気の使用',
                    child: CustomCheckbox(
                      label: '有る場合はチェックを入れてください',
                      value: fire,
                      onChanged: (value) {
                        setState(() {
                          fire = value ?? false;
                        });
                      },
                      borderView: true,
                    ),
                  ),
                  fire
                      ? Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: FormLabel(
                            '火気対策',
                            child: CustomTextField(
                              controller: fireMeasures,
                              textInputType: TextInputType.text,
                              maxLines: 1,
                            ),
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
                        CustomButton(
                          type: ButtonSizeType.sm,
                          label: 'ファイル選択',
                          labelColor: kWhiteColor,
                          backgroundColor: kGreyColor,
                          onPressed: () async {
                            final result = await FilePicker.platform.pickFiles(
                              type: FileType.any,
                            );
                            if (result == null) return;
                            pickedAttachedFiles.addAll(result.files);
                            setState(() {});
                          },
                        ),
                        const SizedBox(height: 4),
                        Column(
                          children: pickedAttachedFiles.map((file) {
                            return AttachedFileList(
                              fileName: p.basename(file.name),
                              onTap: () {
                                pickedAttachedFiles.remove(file);
                                setState(() {});
                              },
                              isClose: true,
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
                    label: '入力内容を確認',
                    labelColor: kWhiteColor,
                    backgroundColor: kBlueColor,
                    onPressed: () async {
                      String? error = await constProvider.check(
                        companyName: companyName.text,
                        companyUserName: companyUserName.text,
                        companyUserEmail: companyUserEmail.text,
                        companyUserTel: companyUserTel.text,
                      );
                      if (error != null) {
                        if (!mounted) return;
                        showMessage(context, error, false);
                        return;
                      }
                      if (!mounted) return;
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: Step2Screen(
                            companyName: companyName.text,
                            companyUserName: companyUserName.text,
                            companyUserEmail: companyUserEmail.text,
                            companyUserTel: companyUserTel.text,
                            constName: constName.text,
                            constUserName: constUserName.text,
                            constUserTel: constUserTel.text,
                            constStartedAt: constStartedAt,
                            constEndedAt: constEndedAt,
                            constAtPending: constAtPending,
                            constContent: constContent.text,
                            noise: noise,
                            noiseMeasures: noiseMeasures.text,
                            dust: dust,
                            dustMeasures: dustMeasures.text,
                            fire: fire,
                            fireMeasures: fireMeasures.text,
                            pickedAttachedFiles: pickedAttachedFiles,
                          ),
                        ),
                      );
                    },
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
