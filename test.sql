/* Level
id   name
1	"A1"
2	"A2"
3	"B1"
4	"B2"
5	"C1"
6	"C2"
*/

/* Specialization
id   name
1	"Công nghệ"
2	"Kế toán"
3	"Kinh doanh"
4	"Y khoa"
5	"Luật"
6	"Tài chính"
7	"Kinh tế"
8	"Nghệ thuật"
9	"Giáo dục"
10	"Kiểm toán"
11	"Xây dựng"
12	"Ngân hàng"
13	"Khoa học"
14	"Nông nghiệp"
15	"Marketing"
*/


/* Type
id   name		isWord
1	"Động từ"	true
2	"Danh từ"	true
3	"Câu cảm thán"	false
4	"Câu hỏi"	false
5	"Tính từ"	true
6	"Trạng từ"	true
7	"Câu đơn"	false
8	"Câu ghép"	false
9	"Đại từ"	true
10	"Giới từ"	true
11	"Từ hạn định"	true
12	"Liên từ"	true
13	"Câu phức"	false
14	"Câu phức tổng hợp"	false
15	"Câu trần thuật"	false
16	"Câu nghi vấn"	false
17	"Câu hỏi Yes-No"	false
18	"Câu hỏi Wh-"	false
19	"Câu hỏi đuôi"	false
20	"Câu hỏi lựa chọn"	false
21	"Câu hỏi trần thuật"	false
22	"Câu hỏi tu từ"	false
23	"Câu hỏi gián tiếp"	false
24	"Câu mệnh lệnh "	false
*/

/* Topic
id  name
1	"Âm nhạc"
2	"Ẩm thực"
8	"Ăn uống"
10	"Thiên nhiên"
11	"Công việc"
12	"Con người"
14	"Thực vật"
15	"Đời sống"
16	"Sức khỏe"
17	"Công nghệ"
18	"Quốc gia"
19	"TOEIC"
20	"IELTS"
36	"Trường học"
37	"Gia đình"
38	"Nghê nghiệp"
39	"Quần áo"
40	"Tính cách"
41	"Sở thích"
42	"Màu sắc"
43	"Môi trường"
44	"Động vật"
45	"Cảm xúc"
46	"Marketing "
47	"Thời trang"
*/

/* Generate word
1.
Từ: abstact
Cấp độ: 4
Chuyên ngành: 8
Phiên âm:ˈæb.strækt
Các từ đồng nghĩa: assistance, benefit, help, support
Các từ trái nghĩa: damage, harm, hindrance
Câu ví dụ
 - He is good at explaining quite complex, abstract ideas in a nice simple way.
 - It is sometimes easier to illustrate an abstract concept by analogy with something concrete.
Nghĩa:
 - 5 trừu tượng

2.
Từ: academism
Cấp độ: 6
Chuyên ngành: 8
Phiên âm:ˈæk.ə.də.mɪ.zəm
Các từ đồng nghĩa: procedure, ritual
Các từ trái nghĩa: informality
Câu ví dụ
 - The artist's work is a reaction against academism.
Nghĩa:
 - 2 chủ nghĩa hàn lâm


3.
Từ: architecture
Cấp độ: 2
Chuyên ngành: 8
Phiên âm:ˈɑːr.kɪ.tek.tʃər
Các từ đồng nghĩa: building, construction, engineering
Các từ trái nghĩa: none
Câu ví dụ
 - The architecture of the building is modern.
Nghĩa:
    - 2 kiến trúc

4.
Từ: artefact
Cấp độ: 4
Chuyên ngành: 8
Phiên âm:ˈɑːr.tɪ.fækt
Các từ đồng nghĩa: art, craft
Các từ trái nghĩa: avocation, cause, destruction
Câu ví dụ
 - The museum has a collection of prehistoric artefacts.
 - The artefacts were discovered in a cave in France.
Nghĩa:
    - 5 đồ tạo tác

5.
Từ: artistic
Cấp độ: 3
Chuyên ngành: 8
Phiên âm:ɑːrˈtɪs.tɪk
Các từ đồng nghĩa: creative, imaginative
Các từ trái nghĩa: uncreative
Câu ví dụ
 - She has an artistic temperament.
 - He is an artistic genius.
Nghĩa:
    - 5 nghệ thuật

-- INSERT INTO public.words(
-- 	id, "levelId", "specializationId", "userId", content, note, phonetic, examples, synonyms, antonyms, "isDeleted", pictures, "createdAt", "updatedAt")
-- 	VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);