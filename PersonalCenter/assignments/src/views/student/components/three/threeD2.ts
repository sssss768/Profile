// 引入封装的类
import ThreeHandler from "@/utils/threeHandler";
import * as THREE from "three";

const threeD2 = new ThreeHandler("threeContainer2", {
	// 需要控制器，但是不需要滚轮
	needControlerConfig: {
		needControler: true,
		needScroll: false,
		needCursor: true,
	},
	needAxesHelper: false,
	needTheme: false,
	needAnimation: true,
});

threeD2.renderer = new THREE.WebGLRenderer({
	alpha: true, // 透明背景
	antialias: true, // 渲染器开启抗锯齿
});

threeD2.needRender = false; // 初始设置不渲染（因为resize的问题）

threeD2.renderer.setClearColor(0xffffff, 0); // 第二个参数是透明度，0表示完全透明

// threeD2.setOtherProps({ // 添加属性，因为有时是不需要渲染的，所以需要加一个渲染-- 已经整体添加了
//   key: "needRender",
//   value: false
// });

export default threeD2;
