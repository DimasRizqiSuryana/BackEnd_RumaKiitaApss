import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../service_locator.dart';
import '../../../utils/constants.dart';
import '../../../utils/helpers.dart';
import '../../../utils/themes.dart';
import '../../blocs/boot/boot_cubit.dart';
import '../../blocs/election_registration/election_registration_cubit.dart';
import '../../blocs/kegiatan_detail/kegiatan_detail_cubit.dart';
import '../../widgets/base_appbar.dart';
import '../../widgets/base_bottom_sheet.dart';
import '../../widgets/base_buttons.dart';
import '../../widgets/base_dialog.dart';
import '../../widgets/base_snackbar.dart';
import '../../widgets/base_text_field.dart';
import '../../widgets/base_typography.dart';
import '../../widgets/status_card.dart';

/// PemilihanScreen
class PemilihanScreen extends StatelessWidget {
  final int id;

  const PemilihanScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<KegiatanDetailCubit>(
          lazy: false,
          create: (context) => sl<KegiatanDetailCubit>(),
        ),
      ],
      child: _PemilihanScreen(
        key: key,
        id: id,
      ),
    );
  }
}

class _PemilihanScreen extends StatefulWidget {
  final int id;

  const _PemilihanScreen({
    super.key,
    required this.id,
  });

  @override
  State<_PemilihanScreen> createState() => __PemilihanScreenState();
}

class __PemilihanScreenState extends State<_PemilihanScreen> {
  void _fetch() {
    BlocProvider.of<KegiatanDetailCubit>(context).dataRequested(widget.id);
  }

  @override
  void initState() {
    super.initState();

    _fetch();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<dynamic> _showElectionRegistrationForm({
    required int kegiatanId,
    required int electionId,
  }) {
    return showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (context) {
        return BlocProvider<ElectionRegistrationCubit>(
          lazy: false,
          create: (context) => sl<ElectionRegistrationCubit>(),
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: _ElectionRegistrationForm(
              kegiatanId: kegiatanId,
              electionId: electionId,
            ),
          ),
        );
      },
    );
  }

  Widget _inProgressWidget() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _failureWidget(KegiatanDetailState state) {
    return Column(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BaseTypography(
                type: 'h3',
                text: state.error!.label,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              BaseElevatedButton(
                onPressed: () {
                  _fetch();
                },
                label: 'Refresh',
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _electionWidget(KegiatanDetailState data) {
    return Column(
      children: [
        SizedBox(
          height: 240.0,
          child: Builder(
            builder: (context) {
              var parties = data
                  .data!.attributes.election!.attributes.electionParty!.data;

              return ListView.builder(
                padding: const EdgeInsets.symmetric(
                  vertical: 24.0,
                ),
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: parties.length,
                itemBuilder: (context, idx) {
                  var party = parties[idx];

                  return Container(
                    margin: EdgeInsets.only(
                      left: idx == 0 ? 16.0 : 0.0,
                      right: 16.0,
                    ),
                    width: 180.0,
                    child: Card(
                      clipBehavior: Clip.hardEdge,
                      color: cTeal,
                      child: InkWell(
                        onTap: () {
                          context.push('/kegiatan/election-party/${party.id}');
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 24.0,
                          ),
                          child: Column(
                            children: [
                              const BaseTypography(
                                text: 'No urut',
                                type: 'label',
                                color: cWhite,
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: BaseTypography(
                                    text: party.attributes.noUrut.toString(),
                                    fontSize: 56.0,
                                    color: cWhite,
                                    fontWeight: fBold,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _successWidget(KegiatanDetailState data) {
    var documentStatus = data.data!.attributes.documentStatus!;
    bool isExpired = false;

    if (DateTime.now()
        .isAfter(DateTime.parse(data.data!.attributes.startDate))) {
      isExpired = true;
    }

    return RefreshIndicator(
      onRefresh: () async {
        _fetch();
      },
      child: ListView(
        children: [
          const SizedBox(height: 24.0),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
            ),
            child: StatusCard(
              status: documentStatus.attributes.status,
              label: documentStatus.attributes.label,
            ),
          ),
          const SizedBox(height: 12.0),
          const Divider(indent: 24.0, endIndent: 24.0),
          const SizedBox(height: 12.0),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
            ),
            child: BaseTypography(
              text: data.data!.attributes.title,
              type: 'h2',
              fontWeight: fBold,
            ),
          ),
          const SizedBox(height: 24.0),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
            ),
            child: BaseTypography(
              text: data.data!.attributes.description ?? '',
            ),
          ),
          const SizedBox(height: 24.0),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24.0,
            ),
            child: BaseTypography(
              text: 'Waktu Pemilihan',
              fontWeight: fBold,
            ),
          ),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
            ),
            child: Card(
              clipBehavior: Clip.hardEdge,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 24.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BaseTypography(
                      text: 'Mulai',
                      color: cBlack,
                      fontWeight: fBold,
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_alarm_rounded,
                        ),
                        const SizedBox(width: 12.0),
                        Expanded(
                          child: BaseTypography(
                            text: formatedDateTime(DateTime.parse(
                              data.data!.attributes.startDate,
                            )),
                            color: cTeal,
                            fontWeight: fBold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24.0),
                    const BaseTypography(
                      text: 'Selesai',
                      color: cBlack,
                      fontWeight: fBold,
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_alarm_rounded,
                        ),
                        const SizedBox(width: 12.0),
                        Expanded(
                          child: BaseTypography(
                            text: formatedDateTime(DateTime.parse(
                              data.data!.attributes.finishDate,
                            )),
                            color: cTeal,
                            fontWeight: fBold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BaseTypography(
                  text: 'Dokumen Kegiatan',
                  fontWeight: fBold,
                ),
                const SizedBox(height: 8.0),
                if (data.data!.attributes.attachment != null)
                  BaseElevatedButton(
                    onPressed: () async {
                      var src = baseUrl;
                      var url =
                          data.data!.attributes.attachment!.attributes.url;
                      var provider =
                          data.data!.attributes.attachment!.attributes.provider;
                      if (provider == 'local') {
                        src += url;
                      } else {
                        src = url;
                      }

                      await launchUrl(Uri.parse(src));
                    },
                    label: 'Buka Dokumen',
                    fontSize: fParagraph,
                    fontWeight: fMedium,
                    backgroundColor: cOrange,
                    foregroundColor: cBlack,
                  )
              ],
            ),
          ),
          const SizedBox(height: 32.0),
          const Divider(indent: 24.0, endIndent: 24.0),
          const SizedBox(height: 12.0),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24.0,
            ),
            child: BaseTypography(
              text: 'Calon Personil',
              type: 'h2',
              fontWeight: fBold,
            ),
          ),
          const SizedBox(height: 24.0),
          if (data.data!.attributes.election != null) _electionWidget(data),
          const SizedBox(height: 32.0),
          const Divider(indent: 24.0, endIndent: 24.0),
          const SizedBox(height: 12.0),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24.0,
            ),
            child: BaseTypography(
              text: 'Pendaftaran',
              type: 'h2',
              fontWeight: fBold,
            ),
          ),
          const SizedBox(height: 24.0),
          if (data.userElection == null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                  ),
                  child: BaseTypography(
                    text: !isExpired
                        ? 'Akun anda belum terdaftar dipemilihan'
                        : 'Pendaftaran telah ditutup',
                  ),
                ),
                const SizedBox(height: 24.0),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                  ),
                  child: BaseElevatedButton(
                    onPressed: !isExpired
                        ? () async {
                            final res = await _showElectionRegistrationForm(
                              kegiatanId: data.data!.id,
                              electionId: data.data!.attributes.election!.id,
                            );

                            if (res != null && res && context.mounted) {}
                          }
                        : null,
                    borderRadius: 64.0,
                    label: 'Daftar',
                    backgroundColor: cTeal,
                    foregroundColor: cWhite,
                  ),
                ),
              ],
            ),
          if (data.userElection != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.0,
                  ),
                  child: BaseTypography(
                    text: 'Akun anda sudah terdaftar',
                  ),
                ),
                const SizedBox(height: 24.0),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                  ),
                  child: Card(
                    clipBehavior: Clip.hardEdge,
                    color: cLightGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 24.0,
                        horizontal: 24.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const BaseTypography(
                            text: 'Akun anda sudah terdaftar',
                            color: cWhite,
                            fontWeight: fBold,
                          ),
                          BaseTypography(
                            text: formatedDateTime(DateTime.parse(
                              data.userElection!.attributes.createdAt,
                            )),
                            type: 'label',
                            color: cWhite,
                          ),
                          const SizedBox(height: 12.0),
                          const Divider(),
                          const SizedBox(height: 12.0),
                          BaseTypography(
                            text: 'No. ${data.userElection!.id}',
                            color: cWhite,
                            fontWeight: fBold,
                          ),
                          const SizedBox(height: 12.0),
                          for (var c
                              in data.userElection!.attributes.voters!.data)
                            BaseTypography(
                              text: c.attributes.name,
                              type: 'h3',
                              color: cWhite,
                            ),
                          const SizedBox(height: 12.0),
                          const Divider(),
                          const SizedBox(height: 12.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const BaseTypography(
                                text: 'Status',
                                color: cWhite,
                                fontWeight: fBold,
                              ),
                              IntrinsicWidth(
                                child: StatusCard(
                                  variant: 'small',
                                  status: data.userElection!.attributes
                                      .documentStatus!.attributes.status,
                                  label: data.userElection!.attributes
                                      .documentStatus!.attributes.label,
                                ),
                              ),
                            ],
                          ),
                          if (data.userElection!.attributes.rejectDescription !=
                                  null &&
                              data.userElection!.attributes.documentStatus!
                                      .attributes.status ==
                                  'rejected')
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const SizedBox(height: 12.0),
                                const Divider(),
                                const SizedBox(height: 12.0),
                                const BaseTypography(
                                  text: 'Alasan ditolak',
                                  color: cWhite,
                                  fontWeight: fBold,
                                ),
                                const SizedBox(height: 8.0),
                                BaseTypography(
                                  text: data.userElection!.attributes
                                      .rejectDescription!,
                                  type: 'label',
                                  color: cWhite,
                                  fontStyle: fItalic,
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          const SizedBox(height: 64.0),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            RumahKitaAppBar(
              left: [
                IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                )
              ],
              middle: const [
                BaseTypography(
                  text: 'Pemilihan RT',
                  type: 'h3',
                  fontWeight: fBold,
                ),
              ],
            ),
            Expanded(
              child: BlocBuilder<KegiatanDetailCubit, KegiatanDetailState>(
                  builder: (context, state) {
                if (state.status.isLoading) {
                  return _inProgressWidget();
                } else if (state.status.isFailure) {
                  return _failureWidget(state);
                } else if (state.status.isSuccess) {
                  return _successWidget(state);
                }

                return const SizedBox.shrink();
              }),
            ),
          ],
        ),
      ),
    );
  }
}

/// ElectionRegistrationForm
class _ElectionRegistrationForm extends StatefulWidget {
  final int kegiatanId;
  final int electionId;

  const _ElectionRegistrationForm({
    // ignore: unused_element
    super.key,
    required this.kegiatanId,
    required this.electionId,
  });

  @override
  State<_ElectionRegistrationForm> createState() =>
      __ElectionRegistrationFormState();
}

class __ElectionRegistrationFormState extends State<_ElectionRegistrationForm> {
  final List<TextEditingController> _controllers = [];

  void _addInput() {
    if (_controllers.length >= 3) return;
    setState(() {
      _controllers.add(TextEditingController());
    });
    BlocProvider.of<ElectionRegistrationCubit>(context).addVoter();
  }

  void _removeInput(int idx) {
    setState(() {
      _controllers.removeAt(idx);
    });
    BlocProvider.of<ElectionRegistrationCubit>(context).removeVoter(idx);
  }

  void _resetInputs() {
    for (var i = 0; i < _controllers.length; i++) {
      var e = _controllers[i];
      e.text = '';
    }
    setState(() {
      _controllers.clear();
    });
  }

  @override
  void initState() {
    super.initState();

    BlocProvider.of<BootCubit>(context).scheduledQueue();

    BlocProvider.of<ElectionRegistrationCubit>(context)
        .kegiatanChanged(widget.kegiatanId);
    BlocProvider.of<ElectionRegistrationCubit>(context)
        .electionChanged(widget.electionId);

    final boot = BlocProvider.of<BootCubit>(context).state;

    for (var i = 0; i < boot.documentStatus.length; i++) {
      var e = boot.documentStatus[i];

      if (e.attributes.status == 'pending') {
        BlocProvider.of<ElectionRegistrationCubit>(context)
            .documentStatusChanged(e.id);
        break;
      }
    }
  }

  @override
  void dispose() {
    for (var i = 0; i < _controllers.length; i++) {
      var e = _controllers[i];
      e.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MultiBlocListener(
        listeners: [
          BlocListener<ElectionRegistrationCubit, ElectionRegistrationState>(
            listener: (context, state) {
              if (state.validation != null) {
                showInfoDialog(
                  context: context,
                  type: 'warning',
                  title: state.validation!.name,
                  body: state.validation!.message,
                );
              } else {
                if (state.status.isSuccess) {
                  _resetInputs();
                  showInfoDialog(
                    context: context,
                    type: 'info',
                    title: 'Berhasil',
                    body: 'Berhasil registrasi',
                  );
                } else if (state.status.isFailure) {
                  showSnackBar(
                    context: context,
                    content: BaseTypography(
                      text: state.error!.message,
                      fontWeight: fLight,
                    ),
                  );
                }
              }
            },
          ),
        ],
        child: Column(
          children: [
            const BottomSheetAppBar(),
            const SizedBox(height: 24.0),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.0,
                    ),
                    child: BaseTypography(
                      text: 'Silahkan masukan data pemilih',
                      fontWeight: fBold,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.0,
                    ),
                    child: BaseTypography(
                      text: '(maksimal 3 pemilih)',
                      type: 'label',
                      fontStyle: fItalic,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: BaseElevatedButton(
                        onPressed: _controllers.length < 3
                            ? () {
                                _addInput();
                              }
                            : null,
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 16.0,
                        ),
                        borderRadius: 32.0,
                        label: 'Tambah Pemilih',
                        fontSize: 14.0,
                        fontWeight: fBold,
                        backgroundColor: cTeal,
                        foregroundColor: cWhite,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  const Divider(indent: 24.0, endIndent: 24.0),
                  const SizedBox(height: 12.0),
                  for (var (idx, c) in _controllers.indexed)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24.0,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: BaseTextField.outlined(
                                  controller: c,
                                  onChanged: (val) {
                                    BlocProvider.of<ElectionRegistrationCubit>(
                                            context)
                                        .voterChanged(idx, val);
                                  },
                                  labelColor: cBlack,
                                  hintText: 'Nama pemilih ${idx + 1}',
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  maxLines: 1,
                                ),
                              ),
                              const SizedBox(width: 4.0),
                              IconButton(
                                onPressed: () {
                                  _removeInput(idx);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  size: 24.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24.0),
                      ],
                    ),
                  const SizedBox(height: 32.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                    ),
                    child: BaseElevatedButton(
                      onPressed: _controllers.isNotEmpty
                          ? () async {
                              final res = await showActionConfirmDialog(
                                context: context,
                                confirmLabel: 'Daftar',
                                children: [
                                  const Center(
                                    child: BaseTypography(
                                      text: 'Daftar pemilihan',
                                      type: 'h3',
                                      textAlign: TextAlign.center,
                                      fontWeight: fBold,
                                    ),
                                  ),
                                  const SizedBox(height: 24.0),
                                  const Center(
                                    child: BaseTypography(
                                      text: 'Kamu yakin ingin melanjutkan?',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              );

                              if (res && context.mounted) {
                                BlocProvider.of<ElectionRegistrationCubit>(
                                        context)
                                    .formSubmitted();
                              }
                            }
                          : null,
                      borderRadius: 64.0,
                      label: 'Daftar',
                      backgroundColor: cTeal,
                      foregroundColor: cWhite,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
