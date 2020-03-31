// 指定要更新的对应的控制器
defineClass("Dolin1VC", {
            // 添加或修改的方法（
            addData: function() {
                var datas = self.arr();
                datas.addObject("test1");
                datas.addObject("test2");
                datas.addObject("test3");
                // 如果添加成功会将数组中的第一个元素打印出来
                console.log(datas.firstObject());
            }
        })
