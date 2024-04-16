import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/features/home/presentation/providers/home_provider.dart';
import 'package:ctue_app/features/notification/presentation/widgets/notification_icon.dart';
import 'package:ctue_app/features/speech/presentation/widgets/pronuc_statistic_box.dart';
import 'package:ctue_app/features/user/business/entities/user_entity.dart';

import 'package:ctue_app/features/user/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserProvider>(builder: (context, provider, child) {
        UserEntity? userEntity = provider.userEntity;

        bool isLoading = provider.isLoading;

        // Access the failure from the provider
        Failure? failure = provider.failure;

        if (failure != null) {
          // Handle failure, for example, show an error message
          return Text(failure.errorMessage);
        } else if (isLoading) {
          // Handle the case where topics are empty
          return const Center(
              child:
                  CircularProgressIndicator()); // or show an empty state message
        } else if (userEntity == null) {
          // Handle the case where topics are empty
          return const Center(child: Text('Không có dữ liệu'));
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  // expandedHeight: 200,
                  backgroundColor: Colors.white,
                  scrolledUnderElevation: 0,
                  floating: false,
                  pinned: false,
                  leading: CircleAvatar(
                    backgroundColor:
                        Colors.white, // Set background color as needed
                    radius: 30,
                    // Set border properties
                    // foregroundColor: Colors.teal, // Border color
                    child: Stack(alignment: Alignment.center, children: [
                      ClipOval(
                        child: SizedBox(
                          height: 60,
                          width: 60,
                          child: userEntity.avt != null
                              ? Image.network(
                                  userEntity.avt!,
                                  fit: BoxFit.cover,
                                )
                              : const FlutterLogo(),
                        ),
                      ),
                      // const Positioned(
                      //     bottom: 2,
                      //     child: Icon(
                      //       Icons.camera_alt,
                      //     ))
                    ]),
                  ),
                  title: Text(userEntity.name),
                  actions: [
                    NotificationIcon(
                      color: Colors.grey.shade400,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RouteNames.setting);
                        Provider.of<HomeProvider>(context, listen: false)
                            .saveRecentPage(RouteNames.setting);
                      },
                      icon: Icon(
                        Icons.settings_rounded,
                        color: Colors.grey.shade400,
                        size: 26,
                      ),
                    ),
                  ],
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    // Your profile content goes here
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Bảng xếp hạng',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(15)),
                      height: 110,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          // Handle onTap
                        },
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15)),
                                  // color: Colors.red,
                                ),
                                child: ListTile(
                                    leading: SizedBox(
                                      height: 45,
                                      width: 45,
                                      child: Image.asset(
                                          'assets/images/icons/medal.png'),
                                    ),
                                    subtitle: Text(
                                      'Cùng xem thành tích của bạn bè và những người khác nhé',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15)),
                                  color: Colors.orange.shade100,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Chi tiết',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: Colors.orange.shade800,
                                            // fontStyle: FontStyle.italic
                                          ),
                                    ),
                                    Icon(
                                      Icons.chevron_right_rounded,
                                      size: 30,
                                      color: Colors.orange.shade800,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Chi tiết',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        height: 390,
                        child: ListView(
                          // shrinkWrap: true,
                          padding: const EdgeInsets.all(8),
                          scrollDirection: Axis.horizontal,
                          children: const [
                            PronuncStatisticBox(),
                            SizedBox(
                              width: 15,
                            ),
                          ],
                        ))
                  ]),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
