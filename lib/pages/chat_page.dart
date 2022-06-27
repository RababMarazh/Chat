import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sajjad/models/message.dart';
import 'package:sajjad/widgets/chat_bublefriend.dart';
import 'package:sajjad/widgets/constants.dart';

import '../widgets/chat_buble.dart';

class Chat_Page extends StatelessWidget {
  Chat_Page({Key? key}) : super(key: key);
  //نعطي اسم للسترنك حتى لا نخطأ بكتابتها 
  static String idhome = 'Home_Pages';
  var id;

  final controllerListView =ScrollController();
  //نستخدم الكونترولر لكي نستطيع التحكم بال بيانات داخل الtextfield
  TextEditingController controller =TextEditingController();
//هنا ننشئ كوليكشن نسمي massagesونعمل اوبجكت منه بنفس الاسم للسهولة فقط 
  CollectionReference messages =
  //هنا نسجل اسم الكوليكلش كثابت في صفحة الثوابت حتى لانستخدمه كسترنك ونخطأ بكتابته
      FirebaseFirestore.instance.collection(kMessagesCollection);
      //
  @override
  Widget build(BuildContext context) {
  var email=  ModalRoute.of(context)!.settings.arguments;
    // لكي استخدم البيانات الموجوده في الفايربيس يجب استخدم فيوجر لانها بيانات مستقبليه ونوعيتها هي كويري سناب شوت
    //نستخدم ستريم لانها تحدث البيانات تلقائي بدون اعادة تشغيل عكس  الفيوجر بلدرتعمل قراءة مره واحدة
    return StreamBuilder<QuerySnapshot>(
      //البيانات التي استدعيها من فايربيس
      //نستخدم الاوردر لترتيب البيانات المستقبلة حسب الموجود داخلها هنا استخدمنا الوقت
      stream: messages.orderBy(kcreatedAd,descending: true).snapshots(),
      
      builder: (context,snapshot){
        //نستخدم الشرط هنا لانه ممكن تتاخر البيانات فيعطي نل ولايعمل
        
        if (snapshot.hasData){
          //نعمل ليست فارغه حتي نستقبل بيها المسجات
          List<Message> messagesList=[];
          //نعمل فور هنا حتي تمر علي المسجات الموجوده واحده واحده
          for(int i =0; i < snapshot.data!.docs.length;i++){
            messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
          }
          return 

                Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/chat.png',
              height: 40,
            ),
            Text('Chat')
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              controller: controllerListView,
              itemCount: messagesList.length,
              itemBuilder: (context, index) {
              return messagesList[index].id==email?
              ChatBuble(massage: messagesList[index],):ChatBuble_Friend(massage: messagesList[index]);
            }),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16, right: 16, left: 16),
            child: TextField(
              controller:controller ,
              //نستخدم ال اونسبمت لانه ترسل المسج كامل بعد الانتهاء ولانستخدم الاونجينج لانها ترسل كل حرف عند كتابته
              onSubmitted: (data){
                messages.add(
                  {//نرسل المسج
                    'message':data,
                    //نرسل الوقت حتى نستطيع ترتيب المسجات
                    kcreatedAd:DateTime.now(),
                    //نرسل الايميل حتي نحدد المستخدم ونستخدم جات ببل مختلفة الشكل
                    'id':email
                    
                    });
                //نستخدم كونترول حتى نتحكم بالداتا ونمسحها بعد ارسالها بال كلير
                controller.clear();
                //نستخدم الاينيميت تو لكي نجعل الليست تتحرك لاخر شي مثلا وممكن استخدام بدلها جمب تو ولكن الجمب تجعل الليست تقفز مباشرة بدون حركة انسيابية
                controllerListView.animateTo(
                  0, 
                  duration: Duration(seconds: 1), 
                  curve: Curves.fastOutSlowIn);
              },
              
              decoration: InputDecoration(
                suffixIcon: (
                  IconButton(
                    onPressed: (){
                      


                    }, 
                    icon: Icon(Icons.send,color: kbuttomColor)
                  
                 
                )),
                hintText: 'send massage',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kbuttomColor)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: kPrimaryColor),
                ),
              ),
            ),
          )
        ],
      ),
    );
 
        }
        //اذا كانت البيانات متاخره او ماموجوده سوف يضر الويجد بعد الريتيرن
        else{
          return Container(
            height: double.infinity,
            width: double.infinity,
            color: kbuttomColor,
            child: Center(child: Text('Loading...')));
        } 
  
      }
      );
    
     }
}
