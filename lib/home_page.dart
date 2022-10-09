import 'package:bucket_list/create_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
	List<String> bucketList = ['여행가기', '앱만들기']; // 전체 버킷리스트 목록

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
                String bucket = bucketList[index]; // index에 해당하는 bucket 가져오기
                return ListTile(
                  // 버킷 리스트 할 일
                  title: Text(
                    bucket,
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  // 삭제 아이콘 버튼
                  trailing: IconButton(
                    icon: Icon(CupertinoIcons.delete),
                    onPressed: () {
                      // 삭제 버튼 클릭시
                      print('$bucket : 삭제하기');
                    },
                  ),
                  onTap: () {
                    // 아이템 클릭시
                    print('$bucket : 클릭 됨');
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
              bucketList.add(job); // 버킷 리스트에 추가
            });
          }
        },
      ),
    );
  }
}
