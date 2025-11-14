import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // Choose a primary orange close to design
  static const Color primaryOrange = Color(0xFFF36B2C);
  static const Color lightGray = Color(0xFFF5F5F7);
  static const Color textGray = Color(0xFF9E9E9E);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Portfolio Template',
          theme: ThemeData(
            primaryColor: primaryOrange,
            scaffoldBackgroundColor: Colors.white,
            fontFamily: 'InterCustom', // use your custom downloaded font
            textTheme: Typography.blackMountainView,
          ),
          home: const MainScaffold(),
        );
      },
    );
  }
}

class MainScaffold extends StatefulWidget {
  const MainScaffold({Key? key}) : super(key: key);

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 1; // default Portfolio

  final List<Widget> _pages = [
    const EmptyPage(title: 'Home'),
    const PortfolioPage(),
    const EmptyPage(title: 'Input'),
    const EmptyPage(title: 'Profile'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: _buildBottomNav(),
      // Floating filter button positioned relative to bottom nav
    );
  }

  Widget _buildBottomNav() {
    final items = [
      _NavItem('Home', 'assets/icons/home.svg'),
      _NavItem('Portfolio', 'assets/icons/portfolio.svg'),
      _NavItem('Input', 'assets/icons/input.svg'),
      _NavItem('Profile', 'assets/icons/profile.svg'),
    ];

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(items.length, (i) {
          final selected = i == _selectedIndex;
          return GestureDetector(
            onTap: () => _onItemTapped(i),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // top indicator
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 4.h,
                  width: 36.w,
                  decoration: BoxDecoration(
                    color: selected ? MyApp.primaryOrange : Colors.transparent,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                SizedBox(height: 6.h),
                SizedBox(
                  height: 24.h,
                  width: 24.w,
                  child: SvgPicture.asset(
                    items[i].iconPath,
                    // The svg should adapt to color via color param
                    color: selected ? MyApp.primaryOrange : Color(0xFFBDBDBD),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  items[i].label,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: selected ? MyApp.primaryOrange : Color(0xFFBDBDBD),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _NavItem {
  final String label;
  final String iconPath;
  _NavItem(this.label, this.iconPath);
}

class EmptyPage extends StatelessWidget {
  final String title;
  const EmptyPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          title,
          style: TextStyle(color: Colors.black, fontSize: 18.sp),
        ),
        centerTitle: false,
      ),
      body: Container(),
    );
  }
}

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({Key? key}) : super(key: key);

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _search = '';

  final List<ProjectCardModel> _data = [
    ProjectCardModel(
      title: 'Kemampuan Merangkum Tulisan',
      subject: 'BAHASA SUNDA',
      author: 'Oleh Al-Baiqi Samaan',
      badge: 'A',
      image: 'assets/images/card1.png',
    ),
    ProjectCardModel(
      title: 'Kemampuan Merangkum Tulisan',
      subject: 'BAHASA SUNDA',
      author: 'Oleh Al-Baiqi Samaan',
      badge: 'A',
      image: 'assets/images/card2.png',
    ),
    ProjectCardModel(
      title: 'Kemampuan Merangkum Tulisan',
      subject: 'BAHASA SUNDA',
      author: 'Oleh Al-Baiqi Samaan',
      badge: 'A',
      image: 'assets/images/card3.png',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<ProjectCardModel> get filteredData {
    if (_search.trim().isEmpty) return _data;
    return _data
        .where((e) => e.title.toLowerCase().contains(_search.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 20.w,
        title: Text(
          'Portfolio',
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Row(
              children: [
                // small bag icon
                SvgPicture.asset(
                  'assets/icons/portfolio.svg',
                  height: 22.h,
                  color: Color(0xFFF36B2C),
                ),
                SizedBox(width: 12.w),
                // bell icon reuse
                SvgPicture.asset(
                  'assets/icons/profile.svg',
                  height: 22.h,
                  color: Color(0xFFF36B2C),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // tabs row (Project, Saved, Shared, Achievement)
              SizedBox(height: 12.h),
              TabBar(
                controller: _tabController,
                labelColor: MyApp.primaryOrange,
                unselectedLabelColor: Colors.black54,
                indicatorColor: MyApp.primaryOrange,
                indicatorWeight: 3.h,
                isScrollable: true,
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14.sp,
                ),
                unselectedLabelStyle: TextStyle(fontSize: 14.sp),
                tabs: const [
                  Tab(text: 'Project'),
                  Tab(text: 'Saved'),
                  Tab(text: 'Shared'),
                  Tab(text: 'Achievement'),
                ],
              ),
              SizedBox(height: 12.h),

              // Search bar
              _buildSearchBar(),

              SizedBox(height: 12.h),

              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Project list (scrollable)
                    _buildProjectList(),
                    // Saved
                    Container(),
                    // Shared
                    Container(),
                    // Achievement
                    Container(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFilterButton(),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Color(0xFFEFEFEF)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: (v) => setState(() => _search = v),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search a project',
                hintStyle: TextStyle(color: Color(0xFFBDBDBD), fontSize: 14.sp),
              ),
            ),
          ),
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: MyApp.primaryOrange,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(Icons.search, color: Colors.white, size: 20.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectList() {
    final list = filteredData;
    return ListView.separated(
      padding: EdgeInsets.only(bottom: 120.h, top: 8.h),
      itemCount: list.length,
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
      itemBuilder: (context, index) {
        final item = list[index];
        return _ProjectCard(model: item);
      },
    );
  }

  Widget _buildFilterButton() {
    return Container(
      margin: EdgeInsets.only(bottom: 56.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(24.r),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: MyApp.primaryOrange,
              borderRadius: BorderRadius.circular(28.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 8.r,
                  offset: Offset(0, 4.h),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.filter_list, color: Colors.white, size: 20.sp),
                SizedBox(width: 8.w),
                Text(
                  'Filter',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProjectCardModel {
  final String title;
  final String subject;
  final String author;
  final String badge;
  final String image;

  ProjectCardModel({
    required this.title,
    required this.subject,
    required this.author,
    required this.badge,
    required this.image,
  });
}

class _ProjectCard extends StatelessWidget {
  final ProjectCardModel model;
  const _ProjectCard({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Color(0xFFECECEC)),
      ),
      child: Row(
        children: [
          // image
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.r),
              bottomLeft: Radius.circular(12.r),
            ),
            child: Image.asset(
              model.image,
              width: 120.w,
              height: 120.h,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.title,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            model.subject,
                            style: TextStyle(
                              fontSize: 12.sp,
                              letterSpacing: 1.2,
                              color: Color(0xFF616161),
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            model.author,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Color(0xFF9E9E9E),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // grade badge
                  Container(
                    margin: EdgeInsets.only(left: 8.w),
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFFFB74D), Color(0xFFF57C00)],
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      model.badge,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
