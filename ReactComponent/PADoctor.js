/**
 * Created by shaolin on 2017/11/27.
 * Description：平安医生组件
 */

'use strict';

import React, {Component} from 'react';
import {
    View,
    Text,
    StyleSheet
} from 'react-native';

var PropTypes = require('prop-types');

import Animation from 'lottie-react-native'

// source
import zhayan from './zhayan.json';
import diantou from './diantou.json';
import think from './think.json';

/*
* 医生状态
* */
export const DoctorStatus = {
    Awake: 'awake',                      // 唤醒
    PreSpeack:'pre_speack',
    Speak:'speack',                      // 讲话
    EndSpeack:'end_speack',
    Wait: 'wait',                        // 等待
    Over: 'over',                        // 结束
    Idle:'idle'                          // 空闲
};

export default class PADoctor extends Component {
    // 属性类型
    static propTypes = {
        doctorStatus:PropTypes.object.isRequired,
        animationCompleteCallcack:PropTypes.func,
    };

    // 默认属性值
    static defaultProps = {

    };

    constructor(props) {
        super(props);
        this.state = {
            doctorStatus:this.props.doctorStatus,
        }
        this.isLoopAnimation = false;                // 是否循环动画
        this.isIdle = false;                         // 是否是空闲状态
        this.doctorStatus = this.props.doctorStatus; // 医生当前状态
    }

    componentWillReceiveProps(nextProps) {
        if (this.props.doctorStatus != nextProps.doctorStatus && nextProps.doctorStatus) {
            this.doctorStatus = nextProps.doctorStatus;
        }
    }

    componentDidMount() {
        this.animation.playWithCompleteCallcack(() => {
            this.props.animationCompleteCallcack();
            this._changeDoctorStatusBySelf();

        });
    }

    componentDidUpdate() {
        this.animation.playWithCompleteCallcack(()=>{
            this.props.animationCompleteCallcack();
            this._changeDoctorStatusBySelf();
        });
    }

    /*
    * 自己更新一些状态
    * */
    _changeDoctorStatusBySelf() {
        if (this.doctorStatus === DoctorStatus.PreSpeack) {
            this.doctorStatus = DoctorStatus.Speak;
            this.setState({
                doctorStatus:this.doctorStatus
            });
        }
    }

    /*
    * 获取资源并设置loop状态
    * */
    _getSourceAndSetLoopStatus() {
        // 默认的source
        let source = zhayan;

        // 根据状态获取source
        if (this.doctorStatus === DoctorStatus.Awake){
            source = diantou;
        }
        else if (this.doctorStatus === DoctorStatus.Wait) {

        }
        else if (this.doctorStatus === DoctorStatus.Over) {

        }
        else if (this.doctorStatus === DoctorStatus.PreSpeack) {
            source = zhayan;
        }
        else if (this.doctorStatus === DoctorStatus.Speak) {
            source = think;
        }
        else if (this.doctorStatus === DoctorStatus.EndSpeack) {

        }
        else if (this.doctorStatus === DoctorStatus.Idle) {

        }

        // 设置是否loop
        if(this.doctorStatus === DoctorStatus.Speak) {
            this.isLoopAnimation = true;
        }

        return source;
    }

    render() {
        // 根据doctorStatusType去拿不同的source，设置isLoopAnimation
        let source = this._getSourceAndSetLoopStatus();
        return (
            <Animation
                ref = {animation => {this.animation = animation;}}
                style = {styles.container}
                source = {source}
                loop = {this.isLoopAnimation}
            />
        );
    }
}

const styles = StyleSheet.create({
    container: {
        position:'absolute',
        width:414,
        height:700,
    },
});
