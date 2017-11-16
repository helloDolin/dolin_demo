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

class NativeRNApp extends Component {
    constructor(props){
        super(props);
        this.state = {
            src:zhayan
        }
    }

    componentDidMount() {
        let self = this;
        setInterval(()=>{
            self.setState({
                src:diantou
            });
            this.animation.play();
        },5000)
        this.animation.play();
    }
    render() {
        return (
            <Animation
                ref = {animation => {this.animation = animation;}}
                style={{
                    width: 414,
                    height: 700,
                }}
                source = {this.state.src}
                loop = {true}
            />
        );
    }
}

AppRegistry.registerComponent('dolin_demo', () => NativeRNApp);
