import * as THREE from "three";
// 引入相机控件
import { OrbitControls } from "three/addons/controls/OrbitControls.js";

class ThreeHandler {
	public scence = new THREE.Scene();
	public camera = new THREE.PerspectiveCamera();
	public renderer = new THREE.WebGLRenderer({
		antialias: true, // 渲染器开启抗锯齿
	});
	public controls: any;
	public container: HTMLElement | null = null;
	public canvasId: string;
	public needControlerConfig: { needControler: boolean; needScroll: boolean } =
		{
			needControler: true,
			needScroll: true,
		};
	public needAxesHelper: boolean = false; // 辅助观察的坐标系
	public needTheme: boolean = true; // 主题切换
	public needAnimation: boolean = false; // 需要动画？
	public needRender: boolean = true; // 初始需要渲染吗？
	private firstInit: boolean = true; // 是否是第一次渲染
	private colorSetting: { day: number; night: number } = {
		day: 0xf5fafc,
		night: 0x242322,
	};
	[key: string]: any; // 索引签名 预留绑定附加属性用

	constructor(
		canvasId: string,
		configs?: {
			needControlerConfig?: {
				needControler: boolean;
				needScroll: boolean;
				needCursor: boolean;
			};
			needAxesHelper?: boolean;
			needTheme?: boolean;
			needAnimation?: boolean;
			colorSetting?: { day: number; night: number };
		}
	) {
		this.canvasId = canvasId;
		if (configs !== undefined) {
			if (configs.needControlerConfig !== undefined) {
				this.needControlerConfig = configs.needControlerConfig;
			}
			if (configs.needAxesHelper !== undefined) {
				this.needAxesHelper = configs.needAxesHelper;
			}
			if (configs.needTheme !== undefined) {
				this.needTheme = configs.needTheme;
			}
			if (configs.needAnimation !== undefined) {
				this.needAnimation = configs.needAnimation;
			}
			if (configs.colorSetting !== undefined) {
				this.colorSetting = configs.colorSetting;
			}
		}
	}

	setOtherProps(
		props: { key: string; value: any }[] | { key: string; value: any }
	) {
		if (Array.isArray(props)) {
			props.forEach((item) => {
				let str = item.key;
				this[str] = item.value; // 绑定到索引签名上
			});
		} else {
			this[props.key] = props.value; // 绑定到索引签名上
		}
	}

	isFulllyInit() {
		if (!this.camera || !this.canvasId) {
			return false;
		} else {
			return true;
		}
	}

	changeCanvasTheme(handler?: Function) {
		if (!this.needRender) {
			this.showMessage("willNotRender");
			return;
		}
		// 根据当前主题颜色进行设置画布的颜色，设置模型颜色
		// 此处需要注意，有模型如果不需要背景色的话，直接走
		if (this.needTheme) {
			let theme = localStorage.getItem("dayOrNight");
			if (!theme) {
				theme = "day";
			}
			// 此处仅仅能改变画布的颜色
			if (theme === "day") {
				// 设置成白色主题类型的
				this.renderer.setClearColor(this.colorSetting.day);
			} else {
				// 设置成黑色主题类型的
				this.renderer.setClearColor(this.colorSetting.night);
			}
		}
		// 调用预留函数
		if (handler) {
			handler();
			this.doRender();
		}
	}

	changeCanvasSize() {
		if (!this.needRender) {
			// 压根就不用渲染，当然不用执行
			this.showMessage("willNotRender");
			return;
		}
		if (!this.isFulllyInit() || !this.container) {
			throw new Error("Please check wether init well!");
		}
		const width = this.container!.offsetWidth;
		const height = this.container!.offsetHeight - 1;
		// onresize 事件会在窗口被调整大小时发生  （这个需要绑定到外面）
		// 重置渲染器输出画布canvas尺寸
		this.renderer.setSize(width, height);
		// 全屏情况下：设置观察范围长宽比aspect为窗口宽高比
		this.camera.aspect = width / height;
		// 渲染器执行render方法的时候会读取相机对象的投影矩阵属性projectionMatrix
		// 但是不会每渲染一帧，就通过相机的属性计算投影矩阵(节约计算资源)
		// 如果相机的一些属性发生了变化，需要执行updateProjectionMatrix ()方法更新相机的投影矩阵
		this.camera.updateProjectionMatrix();
		this.renderer.render(this.scence, this.camera);
		const canvas = this.renderer.domElement;
		canvas.id = this.canvasId;
		this.container.appendChild(canvas); // 放到页面上去
	}

	doRender() {
		if (!this.needRender) {
			this.showMessage("willNotRender");
			return;
		}
		if (!this.isFulllyInit() || !this.container) {
			throw new Error("Please check wether init well!");
		}
		// 先移除之前那个canvas对象（如果有的话）
		let prev = document.getElementById(this.canvasId);
		if (prev) {
			this.container.removeChild(prev);
		}
		// 获取你屏幕对应的设备像素比.devicePixelRatio告诉threejs,以免渲染模糊问题
		this.renderer.setPixelRatio(window.devicePixelRatio);
		// 开始渲染
		this.renderer.render(this.scence, this.camera);
		const canvas = this.renderer.domElement;
		canvas.id = this.canvasId;
		this.container.appendChild(canvas); // 放到页面上去
		if (this.firstInit && this.needControlerConfig.needControler) {
			// 只在初始化的时候设置
			// 设置相机控件轨道控制器OrbitControls
			this.controls = new OrbitControls(this.camera, canvas);
			// 实现小手图标效果
			canvas.style.cursor = "grab";
			canvas.addEventListener("mousedown", () => {
				canvas.style.cursor = "grabbing";
			});
			canvas.addEventListener("mouseup", function () {
				canvas.style.cursor = "grab";
			});
			if (!this.needControlerConfig.needScroll) {
				// 禁用滚轮缩放功能
				this.controls.enableZoom = false;
			}
			// 如果OrbitControls改变了相机参数，重新调用渲染器渲染三维场景
			if (!this.needAnimation) {
				// 如果设置了动画就不需要再绑定change事件重新渲染了
				this.controls.addEventListener("change", () => {
					this.renderer.render(this.scence, this.camera); //执行渲染操作
				}); //监听鼠标、键盘事件
			}
		}
		if (this.firstInit) {
			this.firstInit = false;
		}
	}

	async initThreeD(container: null | HTMLElement, handler: Function) {
		// 整个函数，用函数作为如何init
		if (!this.needRender) {
			this.showMessage("willNotRender");
			return;
		}
		if (!this.isFulllyInit()) {
			throw new Error("Please check wether init well!");
		}
		this.container = container;
		if (this.needAxesHelper) {
			this.scence.add(new THREE.AxesHelper(10000));
		}
		await handler(); // 此处添加的内容如果需要绑定到this身上，使用setOtherProps进行设置
		this.changeCanvasTheme();
		this.changeCanvasSize();
		// 最后：执行渲染
		this.doRender();
	}

	private showMessage(type: string) {
		// 负责打印报警/提示信息的函数
		switch (type) {
			case "willNotRender": {
				console.log(
					"🎯 HAVE SETTED DON NOT RENDER MODEL, IF WANT RENDER, PLEASE SET IT AS TRUE."
				);
				break;
			}
		}
	}
}

export default ThreeHandler;
