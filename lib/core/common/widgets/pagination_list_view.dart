import 'package:assignment_manabie/core/constant/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:assignment_manabie/core/utils/sizer_custom/sizer.dart';

class PaginationListView extends StatefulWidget {
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final Widget childShimmer;
  final Axis scrollDirection;
  final bool isLoadMore;
  final Function? callBackLoadMore;
  final Function(Function)? callBackRefresh;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  const PaginationListView({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,
    required this.childShimmer,
    this.callBackLoadMore,
    this.callBackRefresh,
    this.padding = EdgeInsets.zero,
    this.scrollDirection = Axis.vertical,
    this.isLoadMore = false,
    this.physics,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => _PaginationListViewState();
}

class _PaginationListViewState extends State<PaginationListView> {
  final ScrollController _scrollController = ScrollController();
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  final Key linkKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(
      () {
        if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 2.sp) {
          if (widget.callBackLoadMore != null) {
            widget.callBackLoadMore!();
          }
        }
      },
    );
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullUp: false,
      enablePullDown: widget.callBackRefresh != null,
      header: const WaterDropHeader(
        refresh: CupertinoActivityIndicator(),
        complete: SizedBox(),
        completeDuration: Duration(milliseconds: Constants.delay250Ms ~/ 2),
      ),
      onRefresh: () async {
        if (widget.callBackRefresh != null) {
          widget.callBackRefresh!(() => _refreshController.refreshCompleted());
        } else {
          await Future.delayed(const Duration(milliseconds: Constants.delayHalfSecond));
          _refreshController.refreshCompleted();
        }
      },
      child: ListView.builder(
        controller: _scrollController,
        padding: widget.padding!,
        scrollDirection: widget.scrollDirection,
        physics: widget.physics ?? const BouncingScrollPhysics(),
        itemCount: widget.itemCount + (widget.isLoadMore ? 1 : 0),
        itemBuilder: (context, index) => widget.isLoadMore && index == widget.itemCount
            ? widget.childShimmer
            : widget.itemBuilder(context, index),
      ),
    );
  }
}
