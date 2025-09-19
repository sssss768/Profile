import { ref, onMounted, watchEffect,type Ref, onUnmounted } from "vue";

type IntersectCallbacks = {
	onIntersect: () => void;
	once?: boolean; // 决定回调函数是否只调用一次，默认为true
};

/**
 * @description: 用于实现元素进入可视区域之后执行特定操作的hook
 * @param {Ref<HTMLElement | undefined | null>} elementRef - 一个包装了DOM元素引用的ref对象
 * @param {IntersectionObserverInit=} options - 传递给IntersectionObserver构造函数的可选配置项
 * @param {IntersectCallbacks=} callbacks - 包含进入可视区域时的回调函数以及是否只调用一次的配置项，默认只调用一次
 * @returns {Ref<boolean>} - 一个布尔类型的ref，表示元素是否处于可视区域内
 */
export default function useVisible(
	elementRef: Ref<HTMLElement | undefined | null>,
	callbacks: IntersectCallbacks,
	options?: IntersectionObserverInit
): Ref<boolean> {
	// 创建一个ref用于存储元素是否处于可视区域的状态
	const isIntersecting = ref<boolean>(false);

	// 默认为只执行一次
	callbacks.once ??= true;

	// 用于记录是否已调用过回调函数的状态
	const hasCalledIntersect = ref<boolean>(false);

	// 初始化IntersectionObserver实例变量
	let observer: IntersectionObserver | null = null;

	// 做观察的函数
	const doObserveElement = () => {
		// 检查浏览器是否支持IntersectionObserver以及elementRef是否有值
		if (!elementRef.value || !("IntersectionObserver" in window)) {
			return;
		}

		// 创建新的IntersectionObserver实例，监听元素进入可视区域的情况
		observer = new IntersectionObserver(
			// 回调函数，当观察到元素与视口的交集变化时触发
			(entries: IntersectionObserverEntry[]) => {
				for (const entry of entries) {
					// 更新isIntersecting的值
					isIntersecting.value = entry.isIntersecting;

					// 根据isIntersecting的值调用相应的回调函数
					if (
						entry.isIntersecting &&
						callbacks.once &&
						!hasCalledIntersect.value
					) {
						callbacks.onIntersect();
						hasCalledIntersect.value = true;
					}
				}
			},
			// 传递IntersectionObserver的可选配置项
			options
		);

		// 开始观察指定的DOM元素
		observer.observe(elementRef.value);
	};

	// 停止观察的函数
	const unObserveElement = () => {
		// 如果observer实例存在并且elementRef有值，则停止观察并清空observer实例
		if (observer && elementRef.value) {
			observer.unobserve(elementRef.value);
			observer = null;
			// 重置已调用回调函数的状态
			hasCalledIntersect.value = false;
		}
	};

	// 在组件挂载时开始观察给定元素
	onMounted(doObserveElement);

	// 组件卸载时停止观察给定元素
	onUnmounted(unObserveElement);

	// 使用watchEffect，当elementRef的值发生变化时重新观察元素
	watchEffect(doObserveElement);

	// 返回表示元素是否处于可视区域的ref对象
	return isIntersecting;
}
