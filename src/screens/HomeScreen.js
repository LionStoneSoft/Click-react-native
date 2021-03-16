import React, { useState } from 'react';
import { SafeAreaView, View, Text, StyleSheet, Button, FlatList, Dimensions, Image, Screen } from 'react-native';
import ButtonTile from '../components/ButtonTile';

const data = [
    {key: 1, title: 'coom'},{key: 2, title: 'bum'},{key: 3, title: 'poo'},{key: 4, title: 'poops'},{key: 5, title: 'poo'},{key: 6, title: 'poo'},{key: 7, title: 'poo'},{key: 8, title: 'poo'},{key: 9, title: 'poo'},{key: 10, title: 'poo'},{key: 11, title: 'poo'},{key: 12, title: 'poo'},{key: 13, title: 'poo'},{key: 14, title: 'poo'},{key: 15, title: 'poo'},{key: 16, title: 'poo'},
];

// const data = [
//     { key: 'A' }, { key: 'B' }, { key: 'C' }, { key: 'D' }, { key: 'E' }, { key: 'F' }, { key: 'G' }, { key: 'H' }, { key: 'I' }, { key: 'J' },
//     // { key: 'K' },
//     // { key: 'L' },
//   ];
  
  const formatData = (data, numColumns) => {
    const numberOfFullRows = Math.floor(data.length / numColumns);
  
    let numberOfElementsLastRow = data.length - (numberOfFullRows * numColumns);
    while (numberOfElementsLastRow !== numColumns && numberOfElementsLastRow !== 0) {
      data.push({ key: `blank-${numberOfElementsLastRow}`, empty: true });
      numberOfElementsLastRow++;
    }
  
    return data;
  };
  
  const numColumns = 3;
  export default class HomeScreen extends React.Component {
    renderItem = ({ item, index }) => {
      if (item.empty === true) {
        return <View style={[styles.item, styles.itemInvisible]} />;
      }
      return (
        // <View
        //   style={styles.item}
        // >
        //   <Text style={styles.itemText}>{item.title}</Text>
        // </View>
            <ButtonTile 
                title={item.title}
            />
      );
    };
  
    render() {
      return (
        <FlatList
          data={formatData(data, numColumns)}
          style={styles.container}
          renderItem={this.renderItem}
          numColumns={numColumns}
        />
      );
    }
  }
  
  const styles = StyleSheet.create({
    container: {
      flex: 1,
      marginVertical: 20,
    },
    item: {
      backgroundColor: '#4D243D',
      alignItems: 'center',
      justifyContent: 'center',
      flex: 1,
      margin: 1,
      height: Dimensions.get('window').width / numColumns, // approximate a square
    },
    itemInvisible: {
      backgroundColor: 'transparent',
    },
    itemText: {
      color: '#fff',
    },
  });