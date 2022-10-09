import 'package:bucket_list/create_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


/// 버킷 클래스
class Bucket {
  String job; // 할 일
  bool isDone; // 완료 여부

  Bucket(this.job, this.isDone); // 생성자
}
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
	List<Bucket> bucketList = []; // 전체 버킷리스트 목록

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("버킷 리스트"),
      ),
      body: bucketList.isEmpty
          ? Center(child: Text("버킷 리스트를 작성해 주세요."))
          : ListView.builder(
              itemCount: bucketList.length, // bucketList 개수 만큼 보여주기
              itemBuilder: (context, index) {
                Bucket bucket = bucketList[index]; // index에 해당하는 bucket 가져오기
                return ListTile(
                  // 버킷 리스트 할 일
                  title: Text(
                    bucket.job,
                    style: TextStyle(
                      fontSize: 24,
                      color: bucket.isDone ? Colors.grey : Colors.black,
                      decoration: bucket.isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  // 삭제 아이콘 버튼
                  trailing: IconButton(
                    icon: Icon(CupertinoIcons.delete),
                    onPressed: () {
                      // 삭제 버튼 클릭시
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("정말로 삭제하시겠습니까?"),
                            actions: [
                              // 취소 버튼
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("취소"),
                              ),
                              // 확인 버튼
                              TextButton(
                                onPressed: () {
                                	setState(() {
                                    // index에 해당하는 항목 삭제
                                    bucketList.removeAt(index);
                                  });
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "확인",
                                  style: TextStyle(color: Colors.pink),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  onTap: () {
                    // 아이템 클릭시
                    setState(() {
                      bucket.isDone = !bucket.isDone;
                    });
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          // + 버튼 클릭시 버킷 생성 페이지로 이동
          String? job = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => CreatePage()),
          );
          if (job != null) {
            setState(() {
              Bucket newBucket = Bucket(job, false);
              bucketList.add(newBucket); // 버킷 리스트에 추가
            });
          }
        },
      ),
    );
  }
}
