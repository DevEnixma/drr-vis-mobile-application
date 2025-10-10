import 'package:flutter/material.dart';

import 'widgets/product_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Expanded(
            //   child: CarouselSlider(
            // options: CarouselOptions(
            //   enlargeCenterPage: true,
            //   height: 300.0,
            //   autoPlay: false,
            //   enableInfiniteScroll: true,
            //   viewportFraction: 1,
            //   reverse: false,
            //   autoPlayInterval: Duration(seconds: 2),
            //   scrollDirection: Axis.horizontal,
            //   disableCenter: false,
            //   aspectRatio: 2.0,
            // ),
            // items: [BarChartWidget(), LineChartWidget(), BarChartSample1()].map((i) {
            //   return Builder(
            //     builder: (BuildContext context) {
            //       return Container(
            //         width: MediaQuery.of(context).size.width,
            //         margin: EdgeInsets.symmetric(horizontal: 5.0),
            //         child: i,
            //         );
            //       },
            //     );
            //   }).toList(),
            // )),
            // Expanded(
            //   child: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
            //     if (state is ProductInitial) {
            //       context.read<ProductBloc>().add(ProductFetchEvent(''));
            //     }
            //     if (state is ProductLoadingState) {
            //       WidgetsBinding.instance.addPostFrameCallback((_) {
            //         CustomLoading.showLoadingDialog(context, Theme.of(context).colorScheme.primary);
            //       });
            //     }
            //     if (state is ProductLoadedState) {
            //       WidgetsBinding.instance.addPostFrameCallback((_) {
            //         CustomLoading.dismissLoadingDialog(context);
            //       });
            //       var items = state.products;
            //       return ListView.builder(
            //         itemCount: items.length,
            //         itemBuilder: (context, index) {
            //           final item = items[index];
            //           return ListTile(
            //             title: Text(item.title),
            //             subtitle: Column(
            //               mainAxisAlignment: MainAxisAlignment.start,
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text('Quantity: ${item.id}'),
            //                 Text('Price: ${item.price}'),
            //                 Text('Description: ${item.description}'),
            //               ],
            //             ),
            //           );
            //         },
            //       );
            //     }
            //     // return Center(
            //     //   child: LoadingAnimationWidget.waveDots(
            //     //     color: Theme.of(context).colorScheme.primary,
            //     //     size: 100,
            //     //   ),
            //     // );
            //      return const SizedBox.shrink();
            //   }),
            // ),
            // Product(
            //   context,
            // ),
            // SizedBox(height: 10,),
            Product(
              context,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
