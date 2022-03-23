import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Data/Repository/Firebase/firebase_auth.dart';
import '../../../../Data/Repository/Firebase/firebase_storage.dart';
import '../../../../business_logic/bloc/Dashboard/dashboard_bloc.dart';
import '../../../Components/image_builder.dart';
import '../../../Components/loader.dart';
import '../../../Components/spacers.dart';
import '../../../Declarations/Constants/constants.dart';
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
            Navigator.pop(context);

            Authentication().signOut();
          } else if (state is GameDone) {
            _showMyDialog(context, state.score);
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
          }
          // else if (state is GameDone) {
          //   return buildResultLayout();
          // }
          else {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FutureBuilder(
                      future: FireStoreDataBase().getData(username),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text("leaderboard: ${snapshot.data}");
                        }
                        return const Text("");
                      }),
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
                  )
                ],
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
                  BlocProvider.of<DashboardBloc>(context)
                      .add(Rollice(username));
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

  // Widget buildResultLayout(BuildContext context) =>  _showMyDialog(context);

  Future<void> _showMyDialog(contextBloc, int score) async {
    return showDialog<void>(
      context: contextBloc,
      builder: (BuildContext context) {
        return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            child: SingleChildScrollView(
              child: dialogContent(contextBloc, score),
            ));
      },
    );
  }

  dialogContent(BuildContext context, int score) => Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
              top: 55,
            ),
            margin: const EdgeInsets.only(top: 55),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  "Congratulations",
                  style: TextStyle(
                    fontSize: 25.00,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  "You scored: $score",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.00,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                  ),
                ),
                const HeightSpacer(myHeight: 10.5),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        BlocProvider.of<DashboardBloc>(context).add(Logout());
                      },
                      child: const Text(
                        "End Game",
                        style: TextStyle(
                          fontSize: 20.00,
                          fontWeight: FontWeight.w300,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 50,
            right: 50,
            child: CircleAvatar(
              radius: 49.55,
              backgroundColor: Colors.white,
              foregroundColor: Colors.transparent,
              child: CircleAvatar(
                radius: 47.00,
                backgroundColor: Colors.greenAccent,
                foregroundColor: Colors.transparent,
                child: Align(
                  child: Image.asset(
                    dasboardImages[6],
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
}
