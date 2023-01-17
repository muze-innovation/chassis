import { plainToClass } from 'class-transformer'
import Banner from './spec/Banner'
import exampleData from './source/example.json'

const myData = plainToClass(Banner, exampleData)
myData.onValidate()
