<template>
    <div class="row justify-content-center">
        <h1 class="text-center my-4">Post Component</h1>
        <div class="col-md-6 my-2">
            <div class="mb-3">
                <label for="exampleFormControlInput1" class="form-label">Title</label>
                <input type="email" class="form-control" id="exampleFormControlInput1" v-model="title">
            </div>
            <div class="mb-3">
                <label for="exampleFormControlTextarea1" class="form-label">Body</label>
                <textarea class="form-control" id="exampleFormControlTextarea1" rows="3" v-model="body"></textarea>
            </div>
            <div class="text-center">
                <button class="btn btn-primary" @click="createPost">Create</button>
            </div>
        </div>
    </div>
    <div class="row justify-content-center my-5">
        <h1 class="text-center my-2">Posts</h1>
        <div class="col-md-6 my-4">
            <div v-for="post in posts" class="my-1" :key="post.id">
                <div class="alert alert-success">
                    <span class="me-5 pe-5">Title: {{ post.title }}</span>
                    <span class="me-5 pe-5">Body: {{ post.body }}</span>
                    <span class="btn btn-danger ms-5" @click="deletePost(post.id)">Delete</span>
                </div>
            </div>
        </div>
    </div>
</template>


<script>
export default {
    data() {
        return {
            title: "",
            body: "",
            posts: []
        }
    },

    methods: {

        async fetchingPosts() {
            const res = await fetch("http://localhost:3000/posts", {
                method: "GET",
                headers: {
                    "Content-Type": "application/json"
                }
            })

            const data = await res.json()
            this.posts = data
        },

        async createPost() {
            const requestOptions = {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify({
                    title: this.title,
                    body: this.body
                })
            }
            const res = await fetch("http://localhost:3000/posts", requestOptions)
            const data = await res.json()
            this.posts.push(data)
        },

        async deletePost(id) {
            const requestOptions = {
                method: "DELETE",
                headers: {
                    "Content-Type": "application/json"
                }
            }
            await fetch(`http://localhost:3000/posts/${id}`, requestOptions)
            this.fetchingPosts()
            // const data = this.posts.filter(post => {
            //     post.id != id
            // })
            // this.posts = data
        },

        async showPost() {

        },

        async updatePost() {

        }
    },

    mounted(){
        this.fetchingPosts()
    }
}
</script>