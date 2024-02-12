import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takeaplate/main.dart';
import '../../CUSTOM_WIDGETS/custom_search_field.dart';
import '../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../MULTI-PROVIDER/SearchProvider.dart';
import '../../MULTI-PROVIDER/common_counter.dart';
import '../../Response_Model/SearchHistoryResponse.dart';
import '../../UTILS/app_color.dart';
import '../../UTILS/fontfamily_string.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  var counterProvider =
      Provider.of<CommonCounter>(navigatorKey.currentContext!, listen: false);

  final SearchProvider searchProvider = SearchProvider();
  bool isFavorite = false;
  int currentPage = 1;
  bool isLoading = false;
  bool isRefresh = false;
  bool hasMoreData = true;
  List<HistoryData> searchData = [];

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _loadData();
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Reached the end of the list, load more data
      _loadData();
    }
  }

  void _loadData() async {
    Future.delayed(
      Duration.zero,
      () async {
        if (!isLoading && hasMoreData) {
          try {
            setState(() {
              isLoading = true;
            });

            final nextPageData = await searchProvider.getSearchHistoryList(
              page: currentPage,
            );

            if (nextPageData.data != null && nextPageData.data!.isNotEmpty) {
              setState(() {
                if (mounted) {
                  if (isRefresh == true) {
                    searchData.clear();
                    searchData.addAll(nextPageData.data!);
                    isRefresh = false;

                    currentPage++;
                  } else {
                    searchData.addAll(nextPageData.data!);
                    currentPage++;
                  }
                }
              });
            } else {
              setState(() {
                if (mounted) {
                  hasMoreData = false;
                }
              });
            }
          } catch (error) {
          } finally {
            setState(() {
              if (mounted) {
                isLoading = false;
              }
            });
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        body: Padding(
          padding:
              const EdgeInsets.only(top: 20.0, bottom: 20, left: 28, right: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding:
                    EdgeInsets.only(top: 5.0, right: 20, left: 4, bottom: 10),
                child: CustomText(
                    text: "SEARCH",
                    color: btnbgColor,
                    fontfamilly: montHeavy,
                    sizeOfFont: 20),
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: _searchController,
                focusNode: _searchFocusNode,

                textAlign: TextAlign.start,
                autofocus: true,
                //  focusNode: focusNode,
                style: const TextStyle(
                  fontSize: 18,
                  color: hintColor,
                  fontFamily: montBook,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: editbgColor,
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: const Padding(
                    padding: EdgeInsets.only(right: 20.0, top: 10, bottom: 10),
                    child: Icon(Icons.search, color: hintColor, size: 25),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 13),
                  hintStyle: const TextStyle(
                    color: hintColor,
                    fontFamily: montBook,
                    fontSize: 18,
                  ),
                  hintText: "Search",
                ),
                onEditingComplete: () {
                  // Navigate to login screen
                  Navigator.pushReplacementNamed(
                      arguments: _searchController.text,
                      context,
                      '/SearchResultScreen');
                },
              ),
              const Padding(
                padding: EdgeInsets.only(left: 4.0, top: 30),
                child: CustomText(
                  text: "RECENT SEARCHES",
                  color: btnbgColor,
                  fontfamilly: montHeavy,
                  sizeOfFont: 20,
                ),
              ),
              getSearchList(),
            ],
          ),
        ));
  }

  Future<void> _refreshData() async {
    // Call your API here to refresh the data
    try {
      final refreshedData = await searchProvider.getSearchHistoryList(page: 1);

      if (refreshedData.data != null && refreshedData.data!.isNotEmpty) {
        setState(() {
          currentPage = 1; // Reset the page to 1 as you loaded the first page.
          hasMoreData = true; // Reset the flag for more data.
          isRefresh = true;
          searchData.clear(); // Clear existing data before adding new data.
          searchData.addAll(refreshedData.data!);
        });
      }
    } catch (error) {
      //
    }
  }

  Widget getSearchList() {
    return Expanded(
      child: RefreshIndicator(
        key: _refreshIndicatorKey,
        color: Colors.white,
        backgroundColor: editbgColor,
        strokeWidth: 4.0,
        onRefresh: _refreshData,
        child: ListView.builder(
          controller: _scrollController,
          itemCount: searchData.length + (hasMoreData ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < searchData.length) {
              // Display restaurant card
              return GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(
                      arguments: searchData[index].searchTerm,
                      context,
                      '/SearchResultScreen');
                },
                child: getView(index, searchData[index]),
              );
            } else {
              // Display loading indicator while fetching more data
              return FutureBuilder(
                future: Future.delayed(const Duration(seconds: 1)),
                builder: (context, snapshot) =>
                    snapshot.connectionState == ConnectionState.done
                        ? const SizedBox()
                        : const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(child: CircularProgressIndicator()),
                          ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget getView(int index, HistoryData searchData) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 7.0, top: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                  text: searchData.searchTerm ?? '',
                  color: btntxtColor,
                  fontfamilly: montBold,
                  sizeOfFont: 15),
              CustomText(
                text: searchData.createdAt ?? '',
                color: graysColor,
                fontfamilly: montRegular,
                sizeOfFont: 11,
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Divider(
            height: 0,
            color: grayColor,
            thickness: 0,
          ),
        )
      ],
    );
  }
}
