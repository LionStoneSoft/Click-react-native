import React from 'react';
import { View, Text, StyleSheet, Image, Dimensions, Animated, TouchableOpacity } from 'react-native';
import { withNavigation } from 'react-navigation';

const ButtonTile = ({ title, amount, navigation }) => {
    const animation = new Animated.Value(0);
    const inputRange = [0, 2];
    const outputRange = [1, 0.8];
    const scale = animation.interpolate({inputRange, outputRange});
    const onPressIn = () => {
        Animated.spring(animation, {
          toValue: 1,
          useNativeDriver: true,
          bounciness: 5,
          speed: 70
        }).start();
      };
      const onPressOut = () => {
        Animated.spring(animation, {
          toValue: 0,
          useNativeDriver: true,
          bounciness: 5,
          speed: 70
        }).start();
      };

    return (
    
        <Animated.View style={[{transform: [{scale}]}]}>
            <TouchableOpacity
                //style={styles.btn}
                activeOpacity={1}
                onPressIn={onPressIn}
                onPressOut={onPressOut}
                onLongPress={() => navigation.navigate('Test')}
                >
                <View style={styles.viewStyle}>
                <Text style={styles.btnText}>{title}</Text>
                <Text style={styles.btnText}>{amount}</Text>
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
        width: Dimensions.get('window').width / numColumns - 10,
        borderRadius: 15,
        paddingHorizontal: 15,
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

export default withNavigation(ButtonTile);