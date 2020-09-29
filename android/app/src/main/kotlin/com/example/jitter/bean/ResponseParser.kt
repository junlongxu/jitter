package com.example.jitter.bean

import okhttp3.Response
import rxhttp.wrapper.annotation.Parser
import rxhttp.wrapper.entity.ParameterizedTypeImpl
import rxhttp.wrapper.exception.ParseException
import rxhttp.wrapper.parse.AbstractParser
import rxhttp.wrapper.utils.convert
import java.io.IOException
import java.lang.reflect.Type

/**
 * author: Warrior
 * created: 2020/9/12 15:24
 * descript: 自定义解析器
 */
@Parser(name = "Response")
open class ResponseParser<T> : AbstractParser<T> {

    protected constructor() : super()

    constructor(type: Type) : super(type)

    @Throws(IOException::class)
    override fun onParse(response: Response): T {
        val type: Type = ParameterizedTypeImpl[BaseResponse::class.java, mType]
        val data: BaseResponse<T> = response.convert(type)
        var t = data.data
        if (t == null && mType === String::class.java) {
            @Suppress("UNCHECKED_CAST")
            t = data.msg as T
        }
        if (data.code != 200 || t == null) {
            throw ParseException(data.code.toString(), data.msg, response)
        }
        return t
    }
}