import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roll_a_dice_app/Data/Repository/Firebase/firebase_auth.dart';
import 'package:roll_a_dice_app/Presentation/Declarations/Constants/constants.dart';

import '../../../../business_logic/bloc/Dashboard/dashboard_bloc.dart';
import '../../../Components/image_builder.dart';
import '../../../Components/loader.dart';
import '../../../Components/spacers.dart';
import '../../../Declarations/Images/images.dart';
import '../../LoginPage/Widgets/text_data_widget.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key, required this.title, required this.username})
      : super(key: key);

  final String title;
  final String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<DashboardBloc, DashboardState>(
        listener: (context, state) {
          if (state is LogoutState) {
            Authentication().signOut();
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state is DashboardLoading) {
            return LoadingWidget(
              child: initialLayout(context,
                  diceVal: state.diceVal,
                  changesLeft: state.chancesLeft,
                  score: state.score),
            );
          } else if (state is DashboardLoaded) {
            return initialLayout(context,
                diceVal: state.diceVal,
                changesLeft: state.chancesLeft,
                score: state.score);
          } else if (state is GameDone) {
            return buildResultLayout();
          } else {
            return initialLayout(context,
                diceVal: state.diceVal,
                changesLeft: state.chancesLeft,
                score: state.score);
          }
        },
      ),
    );
  }

  Widget initialLayout(BuildContext context,
          {int? diceVal, int? changesLeft, int? score}) =>
      Center(
        child: Padding(
          padding: kHPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  BlocProvider.of<DashboardBloc>(context).add(Logout());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                    Padding(
                      padding: kHPadding / 10,
                      child: const Text(
                        "Logout",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
              HeightSpacer(myHeight: kSpacing),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: kBorderRadius * 2,
                  color: const Color.fromARGB(255, 203, 236, 252),
                ),
                child: Center(
                  child:
                      TextData(message1: "Score:", message2: score.toString()),
                ),
              ),
              HeightSpacer(myHeight: kSpacing),
              ImageBuilder(
                  imagePath: dasboardImages[diceVal ?? 0],
                  imgWidth: 200,
                  imgheight: 200),
              const HeightSpacer(myHeight: 100),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "chances left",
                    style: TextStyle(fontSize: 15.00, color: Colors.grey),
                  ),
                  const HeightSpacer(myHeight: 5.5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var i = 0; i < changesLeft!; i++)
                        Padding(
                          padding: const EdgeInsets.all(2.5),
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: kBorderRadius * 10),
                          ),
                        ),
                      for (var i = 10; i > changesLeft; i--)
                        Padding(
                          padding: const EdgeInsets.all(2.5),
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 209, 209, 209),
                                borderRadius: kBorderRadius * 10),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              const HeightSpacer(myHeight: 50.00),
              GestureDetector(
                onTap: () {
                  BlocProvider.of<DashboardBloc>(context).add(Rollice());
                },
                child: Container(
                  width: 192,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: kBorderRadius,
                    color: Colors.blue,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      WidthSpacer(myWidth: 7.00),
                      Text(
                        "Roll",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildResultLayout() => const Center(
        child: Text("Game Over"),
      );
}
