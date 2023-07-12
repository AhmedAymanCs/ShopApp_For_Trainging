import 'package:flutter/material.dart';
import 'package:shopapp/modules/login/loginscreen.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/components/constants.dart';
import 'package:shopapp/shared/network/local/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class onBoradingScrren extends StatefulWidget {
  const onBoradingScrren({Key? key}) : super(key: key);

  @override
  _onBoradingScrrenState createState() => _onBoradingScrrenState();
}


class onboarding
{
  final String? image;
  final String? title;
  final String? body;

  onboarding(
      {
        this.image,
        this.title,
        this.body,

      }){}
}

class _onBoradingScrrenState extends State<onBoradingScrren> {

  List<onboarding> onboardinglist=
  [
    onboarding(
      image: 'assets/image/onboarding.png',
      title: 'onboarding Title 1',
      body: 'onboarding body 1'
    ),
    onboarding(
      image: 'assets/image/onboarding.png',
      title: 'onboarding Title 2',
      body: 'onboarding body 2'
  ),
    onboarding(
        image: 'assets/image/onboarding.png',
        title: 'onboarding Title 3',
        body: 'onboarding body 3'
    ),
  ];

  var boardController=PageController();

  bool isLast= false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: (){
                submit();
              },
             child: Text(
               'SKIP',
               style: TextStyle(
                 color: primaryColor
               ),
             )
          ),
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column (
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: PageView.builder(
                  controller: boardController,
                  onPageChanged: (index)
                  {
                  if(index == onboardinglist.length - 1)
                    {
                     isLast=true;
                    }
                  else
                    {
                      isLast=false;
                    }
                  },
                  physics: BouncingScrollPhysics(),
                    itemBuilder: (context,index)=> buildItemOnboard(onboardinglist[index]),
                  itemCount: onboardinglist.length,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                 SmoothPageIndicator(
                   controller: boardController,
                   count: onboardinglist.length,
                   effect: ExpandingDotsEffect(
                     activeDotColor: primaryColor
                   ),
                 ),
                  Spacer(),
                  FloatingActionButton(
                      onPressed: (){
                        setState(() {

                          if(!isLast)
                            {
                              boardController.nextPage(
                                  duration: Duration(
                                    milliseconds: 450,
                                  ),
                                  curve: Curves.fastLinearToSlowEaseIn);
                            }

                          else
                            {
                              submit();
                            }

                        });

                      },
                    child: Icon(
                      Icons.arrow_forward_ios,
                    ),
                    backgroundColor: primaryColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItemOnboard(onboarding item)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Center(
            child: Image.asset('${item.image}',
              height: 300,
              width: 300,
            ),
          ),
        ),
        Text(
          '${item.title}',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          '${item.body}',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  void submit ()
  {
    CacheHelper.putData('onboarding', true).then(
        (value)
            {
              navigatToAndFinish(context, loginScreen());
            }
    );
  }
}
