import React from 'react';
import { View, Text, StyleSheet, Image, Dimensions } from 'react-native';

const ButtonTile = ({ title }) => {
    return (
    <View style={styles.viewStyle}>
        <Text>{title}</Text>
    </View>
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
        borderRadius: 15
    },
});

export default ButtonTile;