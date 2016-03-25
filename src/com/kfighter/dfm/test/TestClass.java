package com.kfighter.dfm.test;

public class TestClass {
	public static void main(String[] args) {
		for (int j = 0; j < 100; j++) {
			int total = 0;
			for (int i = 0; i < 200; i++) {
				float rs = (float) (Math.random() * 200.0f);
				String jx = "";
				String result = "";
				if (rs >= 0 && rs <= 140) {
					jx = "2元话费";
				} else if (rs >= 141 && rs <= 160) {
					jx = "5元话费";
				} else if (rs >= 161 && rs <= 180) {
					jx = "10元话费";
				} else if (rs >= 181 && rs <= 195) {
					jx = "20元话费";
				} else if (rs >= 196 && rs <= 199.1) {
					jx = "50元话费";
				} else if (rs >= 199.2 && rs <= 200) {
					jx = "再来一部";
				}
				if (jx == "再来一部") {
					result = "第" + i + "人抽奖，奖项为：" + jx;
					// System.out.println(result);
					total++;
				}

			}
			System.out.println("总中奖人数：" + total);
		}
	}
}
