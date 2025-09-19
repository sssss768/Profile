import { ref, onMounted, onUnmounted, provide } from "vue";

/**
 * 实现类似PPT切屏的滚动效果的钩子
 * @param passAnchors 提供一个锚点数组，注意数组数据类型要求
 */
export default function usePassiveScroll(
	passAnchors: {
		name: string;
		path: string;
	}[]
) {
	const ALink = document.createElement("a");
	// 锚点数组，但是要去对应元素里加上id才有效，此处配置仅用于动态的生成导航
	const anchors = ref(passAnchors);
	// 下标指针
	const index = ref<number>(0);

	let timer: number | null = null;

	/**
	 * 检测要对index做的修改有效吗
	 * @param index index当前的值
	 * @param addOrSub 加或减，真为加，假为减
	 * @returns 有效否
	 */
	function checkChangeIndexValid(index: number, addOrSub: boolean) {
		if (addOrSub) {
			// 加
			if (index + 1 === anchors.value.length) {
				return false;
			}
		} else {
			// 减
			if (index - 1 < 0) {
				return false;
			}
		}
		return true;
	}

	function dealWheel(e: WheelEvent) {
		// 滚轮事件，桌面端
		e.preventDefault();
		if (timer) {
			clearTimeout(timer);
		}
		timer = window.setTimeout(() => {
			if (e.deltaY > 0) {
				// 监听向下滚动，滚动直接触发锚点点击
				if (checkChangeIndexValid(index.value, true)) {
					++index.value;
				}
			} else {
				// 监听向上滚动，滚动直接触发锚点点击
				if (checkChangeIndexValid(index.value, false)) {
					--index.value;
				}
			}
			ALink.href = anchors.value[index.value].path;
			ALink.click();
		}, 80);
	}

	onMounted(() => {
		window.addEventListener("wheel", dealWheel, { passive: false });
	});

	onUnmounted(() => {
		window.removeEventListener("wheel", dealWheel);
	});

	// 向外暴露一个方法，方便外部别的交互方式更改index
	provide("passiveScrollHandler", {
		indexNow: index.value,
		changeIndex: function (i: number) {
			index.value = i;
		},
		checkChangeIndexValid,
	});
}

