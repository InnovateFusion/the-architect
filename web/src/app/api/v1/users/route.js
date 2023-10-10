import { NextResponse } from "next/server";

export async function POST(req) {
  const { body } = req 
  const options = {
    method: "POST",
    headers: {
      accept: "application/json",
      "content-type": "application/json",
      authorization:
        "Bearer key-114CmzODEXSFYNBd259z30iFZNZ7pcu6HclFjhUyGJndqTENGLv3SsVdC0FCCtQHil9jzs7VWhrV5XfDm7DsgfuQvHhqv2Fp",
    },
    body: JSON.stringify({
      model: "xsarchitectural-interior-design",
      prompt: "a photorealistic family apartment with three bedroom",
      negative_prompt: "Disfigured, cartoon, blurry",
      width: 512,
      height: 512,
      steps: 25,
      guidance: 7.5,
      seed: 0,
      scheduler: "dpmsolver++",
      output_format: "png",
    }),
  };
  try {
    const res = await fetch(
      "https://api.getimg.ai/v1/stable-diffusion/text-to-image",
      options
    );
    const image = await res.json();
    console.log(res);

    return NextResponse.json(image);
  } catch {
    return NextResponse.json({ message: "error" });
  }
}

export async function GET(req) {
  return NextResponse.json({ hello: "there" });
}
