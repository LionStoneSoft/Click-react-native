import React from 'react';
import { View, Text, StyleSheet, Image, Dimensions, Animated, TouchableOpacity } from 'react-native';

const ButtonTile = ({ title }) => {
    const animation = new Animated.Value(0);
    const inputRange = [0, 1];
    const outputRange = [1, 0.8];
    const scale = animation.interpolate({inputRange, outputRange});

    const onPressIn = () => {
        Animated.spring(animation, {
          toValue: 1,
          useNativeDriver: true,
        }).start();
      };
      const onPressOut = () => {
        Animated.spring(animation, {
          toValue: 0,
          useNativeDriver: true,
        }).start();
      };

    return (
    
        <Animated.View style={[{transform: [{scale}]}]}>
            <TouchableOpacity
                //style={styles.btn}
                activeOpacity={1}
                onPressIn={onPressIn}
                onPressOut={onPressOut}>
                <View style={styles.viewStyle}>
                <Text style={styles.btnText}>{title}</Text>
                </View>
            </TouchableOpacity>
        </Animated.View>
    
    );
};
const numColumns = 3;

const styles = StyleSheet.create({
    viewStyle: {
        //backgroundColor: "green",
        backgroundColor: '#4D3',
        alignItems: 'center',
        justifyContent: 'center',
        flex: 1,
        margin: 2,
        height: Dimensions.get('window').width / numColumns, // approximate a square
        width: Dimensions.get('window').width / numColumns,
        borderRadius: 15
    },
    btn: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  btnText: {
    color: '#fff',
    fontSize: 25,
  },
});

export default ButtonTile;