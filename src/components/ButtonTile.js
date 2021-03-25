import React, { useState } from 'react';
import { View, Text, StyleSheet, Image, Dimensions, Animated, TouchableOpacity } from 'react-native';
import { withNavigation } from 'react-navigation';
import { v4 as uuid } from 'uuid'
import AsyncStorage from '@react-native-async-storage/async-storage';



const ButtonTile = ({ title, buttonID, navigation }) => {
    const animation = new Animated.Value(0);
    const inputRange = [0, 2];
    const outputRange = [1, 0.8];
    const scale = animation.interpolate({inputRange, outputRange});
    const [amount, setAmount] = useState(0);

    const updateButtonCount = (num) => {
      console.log('one');
      setAmount(num);
      console.log('two');
      const btnID = buttonID + '_count';
      console.log('three');
      try {
      AsyncStorage.setItem(btnID, num);
      } catch(error) {
        console.log(error);
      }
      console.log('four');
    }

    const createButtonData = () => {
      var buttonData = {
        currentDateTime: Date().toLocaleString(),
        note: ''
      };
      const btnID = buttonID;
      try {
      if (AsyncStorage.getItem(btnID) == null) {
        const initialArray = [];
        initialArray.push(buttonData);
        AsyncStorage.setItem(btnID, initialArray);
        console.log(initialArray.length + " top bum")

        //updateButtonCount(initialArray.length);
      } else {
      AsyncStorage.getItem(btnID)
      .then((buttonData) => {
        const b = buttonData ? JSON.parse(buttonData) : [];
        b.push(buttonData);
        AsyncStorage.setItem(btnID, JSON.stringify(b));
        console.log(b.length + "bottom bum")
        //updateButtonCount(b.length);
      });
    }
  } catch(error) {
    console.log(error);
  }
    };

    const onPressIn = () => {
        Animated.spring(animation, {
          toValue: 1,
          useNativeDriver: true,
          bounciness: 5,
          speed: 70
        }).start();
        // console.log(Date().toLocaleString());
        // console.log(uuid())
        //AsyncStorage.clear();
        createButtonData();
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