import 'package:flutter/material.dart';

class QuickGuide extends StatefulWidget {
  @override
  _QuickGuideState createState() => _QuickGuideState();
}

class _QuickGuideState extends State<QuickGuide> {

  int _selectedIndex = 0;
  double wd;

  Widget symptomPage(){
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Symptoms',
              style: TextStyle(
                color: Colors.green,
                fontFamily: 'Lobster',
                fontSize: wd/12,
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Image.asset('images/light_tiredness.gif', width: wd/3.5,),
                  Card(
                    margin: EdgeInsets.only(left: 8),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(width: 1, color: Colors.deepOrange)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: wd/2.7,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Most Common Symptoms:'),
                            Row(
                              children: [
                                Text('\t\t- '),
                                Text('Fever'),
                              ],
                            ),
                            Row(
                              children: [
                                Text('\t\t- '),
                                Text('Dry Cough'),
                              ],
                            ),
                            Row(
                              children: [
                                Text('\t\t- '),
                                Text('Tiredness'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(width: 1, color: Colors.green)),
                    margin: EdgeInsets.only(left: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: wd/2.7,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Serious Symptoms:'),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('\t\t- '),
                                SizedBox(width: wd/3.1, child: Text('Difficulty breathing / shortness of breath')),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('\t\t- '),
                                SizedBox(width: wd/3.1,child: Text('Chest Pain or Pressure')),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('\t\t- '),
                                SizedBox(width: wd/3.1,child: Text('Loss of speech or movement')),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Image.asset('images/light_cough.gif', width: wd/3.5,),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Image.asset('images/light_fever.gif', width: wd/3.5,),
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(width: 1, color: Colors.deepOrange)),
                    margin: EdgeInsets.only(left: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: wd/2.7,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Less Common Symptoms:'),
                            Row(
                              children: [
                                Text('\t\t- '),
                                Text('Aches and pains'),
                              ],
                            ),
                            Row(
                              children: [
                                Text('\t\t- '),
                                Text('Sore Throat'),
                              ],
                            ),
                            Row(
                              children: [
                                Text('\t\t- '),
                                Text('Diarrhoea'),
                              ],
                            ),
                            Row(
                              children: [
                                Text('\t\t- '),
                                Text('Conjunctivitis'),
                              ],
                            ),
                            Row(
                              children: [
                                Text('\t\t- '),
                                Text('Headache'),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('\t\t- '),
                                SizedBox(width:wd/3.1,child: Text('Loss of Taste or Smell')),
                              ],
                            ),
                            Row(
                              children: [
                                Text('\t\t- '),
                                Text('Skin rash'),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('\t\t- '),
                                SizedBox(width: wd/3.1,child: Text('Discolouration of fingers',)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget instructionPage(){
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: wd/37, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Instructions',
                style: TextStyle(
                  color: Colors.green,
                  fontFamily: 'Lobster',
                  fontSize: wd/12,
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(width: 2, color: Colors.black54)),
              color: Colors.deepOrange.shade100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('🔴🔴'),
                    Text(
                      'Important',
                      style: TextStyle(
                        fontSize: 20,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    SizedBox(height: 5,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('\t\t- '),
                        SizedBox(width: wd/1.65,child: Text('Seek immediate medical attention if you have serious symptoms. Always call before visiting your doctor or health facility.',)),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('\t\t- '),
                        SizedBox(width: wd/1.65,child: Text('People with mild symptoms who are otherwise healthy should manage their symptoms at home.',)),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('\t\t- '),
                        SizedBox(width: wd/1.65,child: Text('On average it takes 5-6 days from when someone is infected with the virus for symptoms to show, however it can take up to 14 days.',)),
                      ],
                    ),
                  ],
                ),
              )
            ),
            Text('Instructions for home isolation:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
            SizedBox(height: 10,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('\t\t- '),
                SizedBox(width: wd/1.6,child: Text('Stay away from household members.')),
              ],
            ),
            SizedBox(height: 5,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('\t\t- '),
                SizedBox(width: wd/1.6,child: Text('Do not go to work, school, or public areas.')),
              ],
            ),
            SizedBox(height: 5,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('\t\t- '),
                SizedBox(width: wd/1.6,child: Text('If you must leave home to get essential medical care, drive yourself, if possible. If you cannot drive yourself, keep as much distance as possible between you and the driver and others (e.g. sit in the back seat), leave the windows down, and wear a mask, if possible. If you do not have a mask, wear a cloth face covering (see below).')),
              ],
            ),
            SizedBox(height: 5,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('\t\t- '),
                SizedBox(width: wd/1.6,child: Text('If someone from outside your household is shopping for you, ask them to leave the food and other supplies at your door, if possible. Pick them up after the person has left. If you need help finding free delivery services, social services, essential items like food and medicines call 2-1-1.')),
              ],
            ),
            SizedBox(height: 10,),
            Text('Ending Isolation and returning to work or school:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
            SizedBox(height: 10,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('\t\t- '),
                SizedBox(width: wd/1.6,child: Text('When your home isolation ends (see box above) you can go back to your usual activities, including returning to work and/or school.')),
              ],
            ),
            SizedBox(height: 5,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('\t\t- '),
                SizedBox(width: wd/1.6,child: Text('Continue to practice physical distancing (stay 6 feet away from others) and to wear a cloth face covering when you are in public settings where other people are present.')),
              ],
            ),
            SizedBox(height: 5,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('\t\t- '),
                SizedBox(width: wd/1.6,child: Text('You do not need to have a negative test or a letter from Public Health to return to work or school.')),
              ],
            ),
            SizedBox(height: 10,),
            Text('Home Care:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
            SizedBox(height: 10,),
            Text('Most people with COVID-19 have mild illness and can recover at home. Here are steps that you    can take to help you get better:', style: TextStyle(decoration: TextDecoration.underline),),
            SizedBox(height: 10,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('\t\t- '),
                SizedBox(width: wd/1.6,child: Text('Rest and drink plenty of fluids.')),
              ],
            ),
            SizedBox(height: 5,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('\t\t- '),
                SizedBox(width: wd/1.6,child: Text('Take over-the-counter medicine such as acetaminophen to reduce fever and pain. Note that children younger than age 2 should not be given any over-the-counter cold medications without first speaking with a doctor.')),
              ],
            ),
            SizedBox(height: 5,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('\t\t- '),
                SizedBox(width: wd/1.6,child: Text('Make a note of when your symptoms started and continue to monitor your health.')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget treatmentPage(){
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Treatment & Prevention',
                style: TextStyle(
                  color: Colors.green,
                  fontFamily: 'Lobster',
                  fontSize: wd/11,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20,),
            Text('Self-Care:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, decoration: TextDecoration.underline),),
            SizedBox(height: 10,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('\t\t- '),
                SizedBox(width: wd/1.6,child: Text('If you feel sick you should rest, drink plenty of fluid, and eat nutritious food. Stay in a separate room from other family members, and use a dedicated bathroom if possible. Clean and disinfect frequently touched surfaces.')),
              ],
            ),
            SizedBox(height: 5,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('\t\t- '),
                SizedBox(width: wd/1.6,child: Text('Everyone should keep a healthy lifestyle at home. Maintain a healthy diet, sleep, stay active, and make social contact with loved ones through the phone or internet. Children need extra love and attention from adults during difficult times. Keep to regular routines and schedules as much as possible.')),
              ],
            ),
            SizedBox(height: 5,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('\t\t- '),
                SizedBox(width: wd/1.6,child: Text('It is normal to feel sad, stressed, or confused during a crisis. Talking to people you trust, such as friends and family, can help. If you feel overwhelmed, talk to a health worker or counsellor.')),
              ],
            ),
            SizedBox(height: 10,),
            Text('Medical treatments:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, decoration: TextDecoration.underline),),
            SizedBox(height: 10,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('\t\t- '),
                SizedBox(width: wd/1.6,child: Text('If you have mild symptoms and are otherwise healthy, self-isolate and contact your medical provider or a COVID-19 information line for advice.')),
              ],
            ),
            SizedBox(height: 5,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('\t\t- '),
                SizedBox(width: wd/1.6,child: Text('Seek medical care if you have a fever, a cough, and difficulty breathing. Have a live chat with the doctor.')),
              ],
            ),
            SizedBox(height: 10,),
            Text('Prevention:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, decoration: TextDecoration.underline),),
            SizedBox(height: 10,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('\t\t- '),
                SizedBox(width: wd/1.6,child: Text('Clean your hands often. Use soap and water, or an alcohol-based hand rub.')),
              ],
            ),
            SizedBox(height: 5,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('\t\t- '),
                SizedBox(width: wd/1.6,child: Text('Maintain a safe distance from anyone who is coughing or sneezing.')),
              ],
            ),
            SizedBox(height: 5,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('\t\t- '),
                SizedBox(width: wd/1.6,child: Text('Wear a mask when physical distancing is not possible.')),
              ],
            ),
            SizedBox(height: 5,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('\t\t- '),
                SizedBox(width: wd/1.6,child: Text('Don’t touch your eyes, nose or mouth.')),
              ],
            ),
            SizedBox(height: 5,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('\t\t- '),
                SizedBox(width: wd/1.6,child: Text('Cover your nose and mouth with your bent elbow or a tissue when you cough or sneeze.')),
              ],
            ),
            SizedBox(height: 5,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('\t\t- '),
                SizedBox(width: wd/1.6,child: Text('Stay home if you feel unwell.')),
              ],
            ),
            SizedBox(height: 20),
            Image.asset('images/prevent.png'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    wd = MediaQuery.of(context).size.width;
    List<Widget> pages = [symptomPage(), instructionPage(), treatmentPage()];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('COVID-19 Quick Guide'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Row(
        children: [
          NavigationRail(
            selectedIconTheme: IconThemeData(color: Colors.deepOrange, size: 40),
            selectedLabelTextStyle: TextStyle(color: Colors.green, fontSize: 14),
            unselectedIconTheme: IconThemeData(color: Colors.grey.shade700, size: 30),
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.selected,
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.bug_report,),
                label: Text('Symptoms'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.event_note,),
                label: Text('Instructions'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.verified_user,),
                label: Text('Treatment'),
              ),
            ],
            elevation: 7,
          ),
          Expanded(
            child: pages[_selectedIndex],
          )
        ],
      ),
    );
  }
}
