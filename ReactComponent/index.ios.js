/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, {Component} from 'react';
import {
    AppRegistry,
    StyleSheet,
    Text,
    View,
    Animated
} from 'react-native';

import Animation from 'lottie-react-native';
import zhayan from './zhayan.json';
import diantou from './diantou.json';
import think from './think.json';

/*
* 大白状态类型
* */
export const DoctorStatusType = {
    Awake: 'awake',                      // 唤醒
    DoctorSpeak: 'doctorSpeak',          // 医生讲话
    AssistantSpeak: 'assistantSpeak',    // 助理讲话
    // 患者讲话时状态 ---begin
    Smile: 'smile',                      // 微笑
    Blink: 'blink',                      // 眨眼
    Nod: 'nod',                          // 点头
    ShakeHead: 'shakeHead',              // 扭头
    // 患者讲话时状态 ---end
    Wait: 'wait',                        // 等待
    Over: 'over'                         // 结束
};

class NativeRNApp extends Component {
    constructor(props){
        super(props);
        this.state = {
            animateSrc:zhayan,
            animateState:'',
        }
        this.index = 0;
        this.animateLoop = false; // 是否循环
    }

    componentDidMount() {
        let self = this;
        setInterval(()=>{
            let source = zhayan;
            if (self.index == 0) {
                source = zhayan;
            }
            else if (self.index == 1) {
                source = diantou;
            }
            else if (self.index == 2) {
                source = think;
            }
            self.setState({
                animateSrc:source
            });
            self.index++;
            if (self.index === 3) self.index = 0;
            this.animation.playWithCompleteCallcack(()=>{
                    
            });

        },5000)
        this.animation.playWithCompleteCallcack((state)=>{
            let {isFinished} = state;
        });
    }
    render() {
        return (
            <Animation
                ref = {animation => {this.animation = animation;}}
                style={{
                    width: 414,
                    height: 700,
                }}
                source = {this.state.animateSrc}
                loop = {true}
            />
        );
    }
}

AppRegistry.registerComponent('dolin_demo', () => NativeRNApp);
