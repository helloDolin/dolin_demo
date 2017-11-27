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
    Animated,
    TouchableOpacity,
} from 'react-native';
import PADoctor, {DoctorStatus} from './PADoctor'

var PropTypes = require('prop-types');

class NativeRNApp extends Component {
    constructor(props) {
        super(props);
        this.state = {
            doctorStatus:DoctorStatus.Awake
        }
    }

    render() {
        return (
            <View style={{flex:1}}>
                <PADoctor
                    doctorStatus={this.state.doctorStatus}
                    animationCompleteCallcack={()=>{
                        console.log('animationCompleteCallcack');
                    }}
                />
                <TouchableOpacity onPress={()=>{
                    this.setState({
                        doctorStatus:DoctorStatus.PreSpeack
                    });
                }}>
                    <View style={{width:414,height:100,backgroundColor:'red'}}></View>
                </TouchableOpacity>
            </View>

        );
    }
}

AppRegistry.registerComponent('dolin_demo', () => NativeRNApp);
