import 'package:book_shop/constants/assets.dart';
import 'package:book_shop/constants/strings.dart';
import 'package:book_shop/logic/bloc/account_bloc.dart';
import 'package:book_shop/logic/bloc/basket_bloc.dart';
import 'package:book_shop/logic/bloc/home_bloc.dart';
import 'package:book_shop/logic/bloc/home_bloc.dart';
import 'package:book_shop/logic/bloc/home_state.dart';
import 'package:book_shop/logic/bloc/home_event.dart';
import 'package:book_shop/logic/cubit/internet_cubit.dart';
import 'package:book_shop/presentation/ui/account_tab.dart';
import 'package:book_shop/presentation/ui/basket_tab.dart';
import 'package:book_shop/presentation/ui/chat_list_screen.dart';
import 'package:book_shop/presentation/ui/home_tab.dart';
import 'package:book_shop/presentation/ui/title_tab.dart';
import 'package:book_shop/presentation/widgets/no_network_flare.dart';
import 'package:book_shop/presentation/widgets/widgets.dart';
import 'package:flare_loading/flare_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_tab_bar/MotionTabBarView.dart';
import 'package:motion_tab_bar/MotionTabController.dart';
import 'package:motion_tab_bar/motiontabbar.dart';

class HomeScreen extends StatefulWidget {
  HomeBloc homeBloc;
  AccountBloc accountBloc;
  @override
  _HomeScreenState createState() => _HomeScreenState();
  HomeScreen({@required this.homeBloc, @required this.accountBloc});
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  MotionTabController _bottomNavController;
  bool bottomInternetStatus = true, bottomFailureStatus = true;
  bool failureInFirstTry = false;
  final _noNetworkFlare = new NoNetworkFlare();
  @override
  void initState() {
    _bottomNavController =
        new MotionTabController(initialIndex: 0, vsync: this, length: 4);
    _bottomNavController.index = 3;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeFailure) {
            setState(() {
              bottomFailureStatus = false;
            });
            print('HomeFAilure status bar should be false');
          } else if (state is HomeSuccess) {
            setState(() {
              bottomFailureStatus = true;
            });
            print('HomeSuccess status bar should be true');
          }
        },
        child: BlocConsumer<InternetCubit, InternetState>(
          listener: (context, state) {
            if (state is InternetConnected) {
              setState(() {
                bottomInternetStatus = true;
              });
            } else if (state is InternetDisconnected) {
              setState(() {
                bottomInternetStatus = false;
              });
            }
          },
          builder: (context, state) {
            if (state is InternetConnected) {
              return Stack(
                children: [
                  MotionTabBarView(
                      controller: _bottomNavController,
                      children: <Widget>[
                        BlocProvider.value(
                          value: widget.accountBloc,
                          child: AccountTab(),
                        ),
                        // ChatListTab(),
                        BlocProvider(
                            create: (BuildContext context) => BasketBloc(),
                            child: BasketTab()),
                        TitleTab(),
                        BlocProvider.value(
                          value: widget.homeBloc,
                          child: HomeTab(),
                        ),
                      ]),
                ],
              );
            } else if (state is InternetDisconnected) {
              return NoNetworkFlare();
            } else if (state is InternetLoading) {
              return Container();
            }
          },
        ),
      )),
      bottomNavigationBar: bottomInternetStatus && bottomFailureStatus
          ? MotionTabBar(
              labels: [
                Strings.bottomNavAccount,
                // Strings.bottomNavListofConversations,
                Strings.bottomNavBasket,
                Strings.bottomNavTitle,
                Strings.bottomNavHome,
              ],
              initialSelectedTab: Strings.bottomNavHome,

              tabIconColor: Color(0xffA3A2A8),
              tabSelectedColor: Color(txfColor), //TODO: needs to be replace
              onTabItemSelected: (int value) {
                print(value);
                setState(() {
                  _bottomNavController.index = value;
                });
              },
              icons: [
                Icons.person,
                // Icons.chat,
                Icons.shopping_basket,
                Icons.book,
                Icons.home,
              ],
              textStyle: TextStyle(
                  color: Colors.black87,
                  fontFamily: "IranSans",
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            )
          : null,
    );
  }

  @override
  void dispose() {
    _bottomNavController.dispose();
    super.dispose();
  }
}
