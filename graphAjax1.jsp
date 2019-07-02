<%@page import="bean.ChartDTO"%>
<%@page import="bean.ChartDAO"%>
<%@page import="java.io.Console"%>
<%@page import="bean.MusicDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="bean.MusicDAO"%>
<%@page import="org.jsoup.Jsoup"%>
<%@page import="org.jsoup.nodes.Document"%>
<%@page import="org.jsoup.nodes.Element"%>
<%@page import="org.jsoup.select.Elements"%>
<%@page import="java.io.IOException"%>
<%@ page language="java" contentType="text/html; charset=UTF8"
	pageEncoding="UTF8"%><%
		ChartDAO dao = new ChartDAO();
		ChartDTO dto = new ChartDTO();
		Document doc = null;
		String song = "89095473;89126699;88965638;89059621;87928158;88261335;88915147;88947057;88965633;88773173;89117145;89091983;88727092;88987356;89143933;89147220;88978973;89011319;89091924;89119858;88824340;88707240;89058209;88686378;88709300;88501296;87840106;88965632;88336380;88890308;88965627;88504833;88732246;89064462;88281290;88511064;88607738;88740321;88510820;87506735;88674285;88728543;89059750;88933143;89126695;89143226;88965631;88074702;88510821;88732247;88948788;88773174;87998685;88707238;86941521;87752744;86380457;88353506;88909978;88725289;88194599;88352905;88951935;82779996;86432095;88559277;88323996;88773175;86925465;88562939;86868163;88611219;88689633;88244288;87315030;88728375;87512697;88773178;88421579;88286541;89101027;85433670;88914149;88316432;89147223;86496239;88697586;88355491;86978532;87101034;88098432;88468830;88295011;89146988;86083393;87957296;88773176;87683188;85803478;88353726;87463712;88542731;88564550;87034188;88419409;88363609;87628996;88557156;88678985;88417558;87271938;88684311;88776558;88703035;88690398;88040624;88391129;87360263;87579522;87647017;88162019;86468828;88914905;88773177;88965635;86978777;88971182;88253990;87699632;89059697;87115262;82689882;87240368;88234302;84861691;87931536;88251225;88965628;87403636;87993384;88149389;88280580;87470580;85448749;87526820;86868102;88573751;87444264;89126578;88470489;88732249;89096273;87538960;87893782;88646493;88928855;88401806;88293633;89021253;88336403;88295436;87235670;88048450;88040625;87413975;87298263;89056956;88159717;88350489;88062821;88671402;87440992;87815703;88117581;87663449;85902355;88736570;89126573;86855495;86594795;88701549;87101441;18082664;88773172;88740322;88857817;89142086;89041088;86311323;87466348;88953188;89147219;89147222;87946017;87906367;89147221;87479651;89117146;88656700;87730738;";
		String[] value = song.split(";");
		//200곡의 각 번호 / 장르, 재생횟수 탐색시 사용 / 수시로 업데이트
		//0번이 200위 / 199번이 1위

		String url1 = "https://www.genie.co.kr/detail/songInfo?xgnm=";
		dao.delete();

		String title = null;
		String genre = null;
		int count = 0;
		String time = null;

		int n = 0;
		for (int i = 0; i < 200; i++) { //1위부터 200위까지 반복
			String url = url1 + String.valueOf(value[199 - i]); // 각 노래 상세페이지
			doc = Jsoup.connect(url).get();

			for (Element el : doc.select("div.info-zone h2.name")) { // title 가져옴
				title = el.text();
				break;
			}

			n = 0;
			for (Element el : doc.select("div.info-zone li span.value")) { // 재생시간 가져올 것 !!!
				if (n < 3) {
					n++;
				} else {
					String xx = el.text();
					time =xx.replaceAll("\\:", "");
					break;
				}
			}

			n = 0;
			for (Element el : doc.select("div.info-zone li span.value")) { // genre 가져옴
				if (n < 2) {
					n++;
				} else {
					genre = el.text();
					break;
				}
			}
			
			n = 0;
			for (Element el : doc.select("div.total p")) { // 재생횟수 가져옴
				if (n < 1) {
					n++;
				} else {
					String xx = el.text();
					count = Integer.parseInt(xx.replaceAll("\\,", "")); // 천단위 콤마 없애고 숫자로 만듦
					break;
				}
			}
			dao.update(title, time, genre, count);
		}

		ArrayList<ChartDTO> list = dao.selectAll();

		ArrayList temp = null;
		ChartDTO dto1 = new ChartDTO();
		int[] popCount = new int[2];
		int[] genreCount = new int[8];
		
		for (int i = 0; i < 2; i++) {
			temp = dao.pop(i);
			popCount[i]=temp.size();
		} // 가요와 팝 각각의 노래수 배열
		
		for (int i = 0; i < 8; i++) {
			temp = dao.genre(i);
			genreCount[i]=temp.size();
		} // 8개 장르별 노래수 배열
	%><%=popCount[0]%>,<%=popCount[1]%>,<%=genreCount[0]%>,<%=genreCount[1]%>,<%=genreCount[2]%>,<%=genreCount[3]%>,<%=genreCount[4]%>,<%=genreCount[5]%>,<%=genreCount[6]%>,<%=genreCount[7]%>