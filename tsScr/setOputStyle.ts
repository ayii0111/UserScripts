type StyleOptions = {
  color?: 'black' | 'red' | 'darkGray' | 'gray' | 'lightGray' | 'purple' | 'brightGray' | 'white',
  bgColor?: 'black' | 'red' | 'green' | 'yellow' | 'blue' | 'magenta' | 'cyan' | 'white',
  bold?: boolean // 默認值將會是 true
};

// // 使用範例
// const oput = setOputStyle({ color: 'red', bgColor: 'yellow' });
// console.log(oput('這是測試字串'));

// const oputDefaultBold = setOputStyle();
// console.log(oputDefaultBold('這是粗體預設字串')); // 默認顯示粗體


// 可以為 console.log 配置樣式
export function setOputStyle(options: StyleOptions = {}) {
  return function (text: string): string {
    const colors: { [key: string]: string } = {
      black: '30', // 黑色
      red: '31', // 紅色
      darkGray: '32', // 深灰
      gray: '33', // 灰色
      lightGray: '34', // 淺灰
      purple: '35', // 紫色
      brightGray: '36', // 亮灰色
      white: '37' // 白色
    };

    const backgroundColors: { [key: string]: string } = {
      black: '40', // 極深墨綠色
      red: '41', // 紅色
      green: '42', // 綠色
      yellow: '43', // 黃色
      blue: '44', // 藍色
      magenta: '45', // 洋紅色
      cyan: '46', // 青色
      white: '47' // 白色
    };

    let styleStart = '\x1b[';

    // 設定文字顏色 (如果沒有提供，則不改變終端機預設文字顏色)
    if (options.color && colors[options.color]) {
      styleStart += `${colors[options.color]}m`;
    }

    // 設定背景顏色 (如果沒有提供，則不改變終端機預設背景顏色)
    if (options.bgColor && backgroundColors[options.bgColor]) {
      styleStart += `\x1b[${backgroundColors[options.bgColor]}m`;
    }

    // 設定粗體 (默認為 true)
    if (options.bold !== false) {
      styleStart += `\x1b[1m`;
    }

    const styleEnd = '\x1b[0m'; // 重置樣式

    return `${styleStart}${text}${styleEnd}`;
  };
}

// 新增一個函式來檢視所有顏色的調用
export function testAllStyles() {
  const colors: Array<'black' | 'red' | 'darkGray' | 'gray' | 'lightGray' | 'purple' | 'brightGray' | 'white'> = ['black', 'red', 'darkGray', 'gray', 'lightGray', 'purple', 'brightGray', 'white'];
  const bgColors: Array<'black' | 'red' | 'green' | 'yellow' | 'blue' | 'magenta' | 'cyan' | 'white'> = ['black', 'red', 'green', 'yellow', 'blue', 'magenta', 'cyan', 'white'];

  colors.forEach((color) => {
    bgColors.forEach((bgColor) => {
      const styledText = setOputStyle({ color, bgColor, bold: true })(`文字顏色: ${color}, 背景顏色: ${bgColor}`);
      console.log(styledText);
    });
  });
}

// 使用範例
// testAllStyles(); // 會輸出所有文字與背景顏色的組合