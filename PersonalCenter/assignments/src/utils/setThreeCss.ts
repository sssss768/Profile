import * as THREE from "three";
import threeD2 from "@/views/student/components/three/threeD2.ts";

export default function setThreeCss(type: boolean) {
	if (type) {
		// 日间
		threeD2.changeCanvasTheme(() => {
			// 删掉光源即可
			threeD2.scence.children.forEach((object) => {
				if (object instanceof THREE.Light) {
					threeD2.scence.remove(object);
				}
			});
		});
	} else {
		// 夜间
		threeD2.changeCanvasTheme(() => {
			// 夜晚添加光源
			// 添加光源
			// 创建一个模拟月光的点光源
			const moonLight = new THREE.PointLight(0x8080ff, 10.0);
			// 点光源位置
			moonLight.position.set(200, 100, 70);
			moonLight.decay = 0.0;
			// 点光源添加到场景中
			threeD2.scence.add(moonLight);
		});
	}
}
