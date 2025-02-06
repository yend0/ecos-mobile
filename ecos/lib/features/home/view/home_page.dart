import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const String _homeIcon = 'assets/icons/ic_home.svg';
  static const String _profileIcon = 'assets/icons/ic_profile.svg';
  static const String _idCardIcon = 'assets/icons/ic_id_card.svg';

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          'Привет! Вадим',
          style: theme.textTheme.titleLarge,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 2));
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.0),
                Card(
                  child: Container(
                    width: double.infinity,
                    height: 128,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 7, 54, 23),
                          Color.fromARGB(255, 2, 36, 14),
                        ],
                        stops: [0, 1],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Заработанные баллы',
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: theme.primaryColor,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '82',
                                style: TextStyle(
                                  fontFamily: 'Outfit',
                                  fontSize: 48,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 4),
                              Baseline(
                                baseline: 52,
                                baselineType: TextBaseline.alphabetic,
                                child: Text(
                                  'балла',
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    _buildFeatureCard(
                      icon: Icons.pin_drop,
                      text: 'Найти бак',
                    ),
                    SizedBox(width: 16.0),
                    _buildFeatureCard(
                      svgAsset: HomePage._idCardIcon,
                      text: 'Ваша карточка',
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text(
                    'Последний взнос',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: ListView.separated(
                    shrinkWrap: true, // Ограничиваем высоту списка
                    physics:
                        NeverScrollableScrollPhysics(), // Отключаем прокрутку, чтобы ListView не конфликтовал с SingleChildScrollView
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    itemCount: 3, // Количество элементов в списке
                    separatorBuilder: (context, index) => Divider(
                      height: 1,
                      color: Colors.grey[300],
                    ),
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          'Апрель ${index + 1}',
                          style: theme.textTheme.titleMedium,
                        ),
                        subtitle: Text(
                          '17:03',
                          style: theme.textTheme.bodyMedium,
                        ),
                        trailing: Text(
                          '+${(index + 1) * 10} бал.',
                          style: TextStyle(
                            fontFamily: 'Outfit',
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 8.0,
        ),
        child: SizedBox(
          width: double.infinity,
          height: 56.0,
          child: FloatingActionButton.extended(
            label: Text(
              'Добавить пункт',
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: theme.primaryColor,
              ),
            ),
            foregroundColor: theme.primaryColor,
            backgroundColor: Colors.black,
            onPressed: () => {},
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        selectedLabelStyle: theme.textTheme.bodySmall,
        unselectedLabelStyle: theme.textTheme.bodySmall,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              HomePage._homeIcon,
              height: 24,
              width: 24,
              colorFilter:
                  ColorFilter.mode(theme.disabledColor, BlendMode.srcIn),
            ),
            activeIcon: SvgPicture.asset(
              HomePage._homeIcon,
              height: 24,
              width: 24,
              colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
            ),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.recycling_rounded,
              size: 24,
              color: theme.disabledColor,
            ),
            activeIcon: Icon(
              Icons.recycling_rounded,
              size: 24,
            ),
            label: 'Переработка',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              HomePage._profileIcon,
              height: 24,
              width: 24,
              colorFilter:
                  ColorFilter.mode(theme.disabledColor, BlendMode.srcIn),
            ),
            activeIcon: SvgPicture.asset(
              HomePage._profileIcon,
              height: 24,
              width: 24,
              colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
            ),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({
    IconData? icon,
    String? svgAsset,
    required String text,
    VoidCallback? onTap,
  }) =>
      Expanded(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
            width: double.infinity,
            height: 132,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 2,
                    ),
                  ),
                  child: icon != null
                      ? Icon(icon, color: Colors.black, size: 32)
                      : SvgPicture.asset(
                          svgAsset!,
                          height: 32,
                          width: 32,
                          colorFilter: ColorFilter.mode(
                            Colors.black,
                            BlendMode.srcIn,
                          ),
                        ),
                ),
                SizedBox(height: 8),
                Text(
                  text,
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
