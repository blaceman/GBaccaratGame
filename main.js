require('NSArray');
defineClass('ViewController', {
            viewDidLoad: function() {
            self.super().viewDidLoad();
            self.ORIGviewDidLoad();
            self.setArr(["1","2","阿西吧","3"]);
            var str = self.arr().objectAtIndex(2);
            console.log("JSPatch调用" , str);
            },
            });

//self.ORIGupdateContent();
//在这行代码后面加上你需要修改的代码，上面一句代码相当于把整个方法已经执行了一遍，所以我们不需要把整个方法的代码进行替换(好像暂时没用)
