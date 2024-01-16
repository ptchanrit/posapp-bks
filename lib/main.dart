import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import './widget/card.dart';
import 'widget/sugar_silder.dart';
import './page/payment.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      scaffoldBackgroundColor: Colors.grey[200],
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.red,
      ),
    ),
    home: const CarouselWithIndicatorDemo(),
  ));
}

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          height: 200.0,
          margin: const EdgeInsets.fromLTRB(5, 5, 5, 0),
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(25.0)),
              child: Stack(
                children: <Widget>[
                  Image.network(item, fit: BoxFit.cover, width: 1500.0),
                ],
              )),
        ))
    .toList();

class MenuProvider extends ChangeNotifier {
  List<String> selectedMenus = [];

  void addSelectedMenu(String menu) {
    selectedMenus.add(menu);
    notifyListeners();
  }

  void removeSelectedMenu(String menu) {
    selectedMenus.remove(menu);
    notifyListeners();
  }
}

class CarouselWithIndicatorDemo extends StatefulWidget {
  const CarouselWithIndicatorDemo({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int current = 0;
  // int _currentStep = 0;

  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar:
        //     AppBar(title: const Text('Carousel with indicator controller demo')),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      // Expanded(
      CarouselSlider(
        items: imageSliders,
        carouselController: _controller,
        options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: false,
          aspectRatio: 2.0,
          height: 250,
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: imgList.asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () => _controller.animateToPage(entry.key),
            child: Container(
              width: 12.0,
              height: 12.0,
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black)
                      .withOpacity(current == entry.key ? 0.9 : 0.4)),
            ),
          );
        }).toList(),
      ),
      // )
      const Expanded(child: StepperPage()),
    ]));
  }
}

class StepperPage extends StatefulWidget {
  const StepperPage({super.key});

  @override
  State<StepperPage> createState() => _StepperState();
}

class _StepperState extends State<StepperPage> {
  int _currentStep = 0;
  String getSummary() {
    switch (_currentStep) {
      case 1:
        return 'Selected products: ...'; // Add your logic for step 1 summary
      case 2:
        return 'Selected machine: ...'; // Add your logic for step 2 summary
      default:
        return ''; // No summary for step 0
    }
  }

  final ButtonStyle style = ElevatedButton.styleFrom(
      backgroundColor: Colors.red,
      textStyle: const TextStyle(color: Colors.white));

  List<String> selectedMenuItems = [];
  int activeCategoryIndex = 0; // Default: First category selected
  List<String> categories = ['Category 1', 'Category 2', 'Category 3'];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MenuProvider()),
      ],
      child: Stepper(
        type: StepperType.horizontal,
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep < 3) {
            setState(() {
              _currentStep += 1;
            });
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() {
              _currentStep -= 1;
            });
          }
        },
        steps: [
          Step(
            title: const Text('เลือกน้ำ'),
            content: SizedBox(
              height: 750, // Adjust the height as needed
              child: Row(
                children: [
                  const Expanded(
                    child: ProductMenuGrid(heightSize: 100),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 16.0, top: 16),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('รายการสินค้า',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold)),
                        Text(
                            getSummary()), // Display the summary based on the active step

                        const MenuListView(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            isActive: _currentStep == 0,
          ),
          Step(
            title: const Text('เลือกเครื่อง'),
            content: SizedBox(
              height: 750, // Adjust the height as needed
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: <Widget>[
                                ElevatedButton(
                                  style: style,
                                  onPressed: () {
                                    // Change the active category when the button is pressed
                                    setState(() {
                                      activeCategoryIndex =
                                          (activeCategoryIndex + 1) %
                                              categories.length;
                                    });
                                  },
                                  child: const Text('P'),
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                  child: const Icon(Icons.navigation),
                                  onPressed: () {
                                    // Change the active category when the button is pressed
                                    setState(() {
                                      activeCategoryIndex =
                                          (activeCategoryIndex + 1) %
                                              categories.length;
                                    });
                                  },
                                ),
                              ],
                            )
                          ])),
                  const Expanded(
                    flex: 4,
                    child: ProductMenuGrid(heightSize: 70),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 16.0, top: 16),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('รายการสินค้า',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold)),
                        Text(
                            getSummary()), // Display the summary based on the active step

                        const MenuListView(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            isActive: _currentStep == 1,
          ),
          Step(
            title: const Text('เลือกระดับน้ำตาล'),
            content: SizedBox(
              height: 750.0, // Adjust the height as needed
              child: Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25.0)),
                        child: Container(
                            margin:
                                const EdgeInsets.only(left: 16.0, right: 16.0),
                            color: Colors.white,
                            child: const SugarSilder())),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 16.0, top: 16),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('รายการสินค้า',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold)),
                        Text(getSummary()),
                        const MenuListView(), // Display the summary based on the active step
                      ],
                    ),
                  ),
                ],
              ),
            ),
            isActive: _currentStep == 2,
          ),
          Step(
            title: const Text('ชำระเงิน'),
            content: SizedBox(
              height: 750.0, // Adjust the height as needed
              child: Row(
                children: [
                  const Expanded(
                    child: CardListPaymentWidget(),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 16.0, top: 16),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('รายการสินค้า',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold)),
                        Text(getSummary()),
                        const MenuListView(), // Display the summary based on the active step
                      ],
                    ),
                  ),
                ],
              ),
            ),
            isActive: _currentStep == 3,
          ),
        ],
      ),
    );
  }
}

class MenuListView extends StatelessWidget {
  const MenuListView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedMenus = Provider.of<MenuProvider>(context).selectedMenus;

    return Container(
      width: 300.0,
      height: 650.0,

      color: Colors.white, // Set the background color to #FAFAFA
      child: ListView.builder(
        itemCount: selectedMenus.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 5.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  topLeft: Radius.circular(24)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: const Offset(0, 4), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Display an image (you can replace the placeholder URL)
                Container(
                  width: 100.0,
                  height: 100.0,
                  margin: const EdgeInsets.only(right: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: const DecorationImage(
                      image: NetworkImage(
                          'https://picsum.photos/300/300/?image=1'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Display name, price, and an editable text field
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        ' ${selectedMenus[index]}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Text(
                          'ราคา: 19.99 บาท '), // Replace with actual price
                      const SizedBox(height: 5.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 5.0),
                          ElevatedButton(
                            onPressed: () {
                              Provider.of<MenuProvider>(context, listen: false)
                                  .removeSelectedMenu(selectedMenus[index]);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red),
                            child: const Text(
                              'Edit',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
